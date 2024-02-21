import Action
import RxCocoa
import RxSwift

/// View model for managing the launch list.
struct LaunchListViewModel {

    typealias GetLaunchListAction = Action<Void, [LaunchListItem]>

    // MARK: - Private interface
    /// Represents the loading state of the launch list.
    private enum LoadingType {
        /// Indicates initial loading.
        case initialLoading
        /// Indicates loading more launches during scrolling.
        case loadingMore
        /// Indicates updating the list, typically due to pull-to-refresh action.
        case updating
    }

    /// Dispose bag to store subscriptions.
    private let bag = DisposeBag()
    /// Service for fetching launch data.
    private let launchService: LaunchService
    /// Use case for getting the launch list.
    private let getLaunchListUseCase: GetLaunchListUseCase
    /// Use case for prefetching the launch list.
    private let getPrefetchingLaunchListUseCase: GetLaunchListUseCase
    /// Relay for holding the list of launches.
    private let launchListRelay = BehaviorRelay<[LaunchListItem]>(value: [])
    /// Relay for holding the current loading type.
    private let loadingTypeRelay = BehaviorRelay<LoadingType>(value: .initialLoading)
    /// Number of launches to load initially.
    private let numberOfLaunchesToLoad = 20
    /// Number of launches to prefetch.
    private let numberOfLaunchesToPrefetch = 10
    /// Number of remaining launches to start prefetching.
    private let numberOfRemainingLaunchesToPrefetch = 2

    // MARK: - Initialization
    /// Initializes the launch list view model.
    /// - Parameter service: Service for fetching launch data.
    init(service: LaunchService) {
        self.launchService = service
        getLaunchListUseCase = GetLaunchListUseCase(launchService: service)
        getPrefetchingLaunchListUseCase = GetLaunchListUseCase(launchService: service)
    }
}

// MARK: - LaunchListViewModelType
extension LaunchListViewModel: LaunchListViewModelType {

    /// The input for the launch list view model.
    struct Input: LaunchListInput {
        let viewDidLoad: Driver<Void>
        let selectedLaunch: Driver<LaunchListItem>
        let rowsToPrefetch: Driver<[Int]>
        let didPullToRefresh: Driver<Void>
        let selectedLaunchesType: Driver<LaunchListDisplayType>
    }

    /// The output for the launch list view model.
    struct Output: LaunchListOutput {
        let errors: Driver<Error>
        let isLoading: Driver<Bool>
        var isPrefetching: Driver<Bool>
        var isRefreshing: Driver<Bool>
        let cells: Driver<[LaunchListSection]>
    }

    /// Transforms the input into output for the launch list.
    /// - Parameter input: The input for the 'LaunchListViewModel'.
    /// - Returns: The output for the 'LaunchListViewModel'.
    func transform(input: LaunchListInput) -> LaunchListOutput {
        let type = input.selectedLaunchesType.asObservable()
        let requestOffset = launchListRelay.map { $0.count }

        let getLaunchListAction = getLaunchListUseCase.produce(
            input: (.init(type: type,
                          limit: Observable.just(numberOfLaunchesToLoad),
                          offset: Observable.just(0)))
        )

        let getPrefetchingLaunchListAction = getPrefetchingLaunchListUseCase.produce(
            input: (.init(type: type,
                          limit: Observable.just(numberOfLaunchesToPrefetch),
                          offset: requestOffset))
        )

        bindViewDidLoad(input.viewDidLoad, action: getLaunchListAction)
        bindRowsToPrefetch(input.rowsToPrefetch, action: getPrefetchingLaunchListAction)
        bindDidPullToRefresh(input.didPullToRefresh, action: getLaunchListAction)
        bindSelectedLaunchesType(input.selectedLaunchesType, action: getLaunchListAction)


        let isLoading = createIsLoading(action: getLaunchListAction)
        let isPrefetching = createIsPrefetching(action: getPrefetchingLaunchListAction)
        let isRefreshing = createIsRefreshing(action: getLaunchListAction)
    private func bindViewDidLoad(_ viewDidLoad: Driver<Void>, action: GetLaunchListAction) {
        viewDidLoad
            .drive(action.inputs)
            .disposed(by: bag)
    }

    private func bindRowsToPrefetch(_ rowsToPrefetch: Driver<[Int]>, action: GetLaunchListAction) {
        let shoudPrefetch = rowsToPrefetch
            .filter { $0.contains(launchListRelay.value.count - numberOfRemainingLaunchesToPrefetch) }
            .map { _ in }

        shoudPrefetch
            .map { _ in LoadingType.loadingMore }
            .drive(loadingTypeRelay)
            .disposed(by: bag)

        shoudPrefetch
            .drive(action.inputs)
            .disposed(by: bag)
    }

    private func bindDidPullToRefresh(_ didPullToRefresh: Driver<Void>, action: GetLaunchListAction) {
        didPullToRefresh
            .map { _ in LoadingType.updating }
            .drive(loadingTypeRelay)
            .disposed(by: bag)

        didPullToRefresh
            .drive(action.inputs)
            .disposed(by: bag)
    }

    private func bindSelectedLaunchesType(_ selectedLaunchesType: Driver<LaunchListDisplayType>,
                                          action: GetLaunchListAction) {
        let didChangeLaunchType = selectedLaunchesType
            .skip(1)

        didChangeLaunchType
            .map { _ in [LaunchListItem]() }
            .drive(launchListRelay)
            .disposed(by: bag)

        didChangeLaunchType
            .map { _ in LoadingType.initialLoading }
            .drive(loadingTypeRelay)
            .disposed(by: bag)

        didChangeLaunchType
            .map { _ in }
        getLaunchListAction.elements
            .bind(to: launchListRelay)
            .disposed(by: bag)

        getPrefetchingLaunchListAction.elements
            .withLatestFrom(loadingTypeRelay) { ($0, $1) }
            .filter { $1 == .loadingMore }
            .withLatestFrom(launchListRelay) { new, current in current + new.0 }
            .bind(to: launchListRelay)
            .disposed(by: bag)

        let cells = launchListRelay
            .asDriver()
            .map { [LaunchListSection(items: $0)] }

        let error = getLaunchListAction.errorDriver
    private func createIsLoading(action: GetLaunchListAction) -> Driver<Bool> {
        action.fetchingDriver
            .withLatestFrom(loadingTypeRelay.asDriver()) { ($0, $1) }
            .filter { $1 == .initialLoading }
            .map { $0.0 }
    }

    private func createIsPrefetching(action: GetLaunchListAction) -> Driver<Bool> {
        let isStillPrefetching = loadingTypeRelay
            .filter { $0 != .loadingMore }
            .map { _ in false }
            .asDriver(onErrorDriveWith: .never())

        return Driver
            .merge(isStillPrefetching, action.fetchingDriver)
            .distinctUntilChanged()
    }

    private func createIsRefreshing(action: GetLaunchListAction) -> Driver<Bool> {
        let isStillRefreshing = loadingTypeRelay
            .filter { $0 != .updating }
            .map { _ in false }
            .asDriver(onErrorJustReturn: false)

        let endRefreshing = action.fetchingDriver
            .withLatestFrom(loadingTypeRelay.asDriver()) { ($0, $1) }
            .filter { $0 == false && $1 == .updating }
            .map { _ in false }

        return Driver
            .merge(isStillRefreshing, endRefreshing)
    }

        return Output(errors: error,
                      isLoading: isLoading,
                      isPrefetching: isPrefetching,
                      isRefreshing: isRefreshing,
                      cells: cells)
    }

    /// Constructs the input for the 'LaunchListViewModel'.
    /// - Parameters:
    ///   - viewdDidLoad: Emits when the view is loaded.
    ///   - selectedLaunch: Emits the selected launch item.
    ///   - rowsToPrefetch: Emits when the rows need to be prefetched.
    ///   - selectedLaunchesType: Emits the type of launch list display.
    /// - Returns: The input for the launch list view model.
    func input(viewdDidLoad: Driver<Void>,
               selectedLaunch: Driver<LaunchListItem>,
               rowsToPrefetch: Driver<[Int]>,
               didPullToRefresh: Driver<Void>,
               selectedLaunchesType: Driver<LaunchListDisplayType>) -> LaunchListInput {
        Input(viewDidLoad: viewdDidLoad,
              selectedLaunch: selectedLaunch,
              rowsToPrefetch: rowsToPrefetch,
              didPullToRefresh: didPullToRefresh,
              selectedLaunchesType: selectedLaunchesType)
    }
}
