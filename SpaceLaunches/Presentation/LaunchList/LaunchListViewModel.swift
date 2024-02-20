import RxCocoa
import RxSwift

/// View model for managing the launch list.
struct LaunchListViewModel {

    // MARK: - Private interface
    /// Dispose bag to store subscriptions.
    private let bag = DisposeBag()
    /// Service for fetching launch data.
    private let launchService: LaunchService
    /// Use case for getting the launch list.
    private let getLaunchListUseCase: GetLaunchListUseCase
    /// Relay for holding the list of launches.
    private let launchListRelay = BehaviorRelay<[LaunchListItem]>(value: [])
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
    }
}

// MARK: - LaunchListViewModelType
extension LaunchListViewModel: LaunchListViewModelType {

    /// The input for the launch list view model.
    struct Input: LaunchListInput {
        let viewDidLoad: Driver<Void>
        let selectedLaunch: Driver<LaunchListItem>
        let rowsToPrefetch: Driver<[Int]>
        let selectedLaunchesType: Driver<LaunchListDisplayType>
    }

    /// The output for the launch list view model.
    struct Output: LaunchListOutput {
        let errors: Driver<Error>
        let isLoading: Driver<Bool>
        var isPrefetching: Driver<Bool>
        let cells: Driver<[LaunchListSection]>
    }

    /// Transforms the input into output for the launch list.
    /// - Parameter input: The input for the 'LaunchListViewModel'.
    /// - Returns: The output for the 'LaunchListViewModel'.
    func transform(input: LaunchListInput) -> LaunchListOutput {
        let type = input.selectedLaunchesType
            .asObservable()

        let requestOffset = launchListRelay
            .map { $0.count }

        let limit = launchListRelay
            .map { $0.isEmpty ? numberOfLaunchesToLoad : numberOfLaunchesToPrefetch }

        let getLaunchListAction = getLaunchListUseCase.produce(
            input: (.init(type: type,
                          limit: limit,
                          offset: requestOffset))
        )

        input.viewDidLoad
            .drive(getLaunchListAction.inputs)
            .disposed(by: bag)

        input.rowsToPrefetch
            .filter { $0.contains(launchListRelay.value.count - numberOfRemainingLaunchesToPrefetch) }
            .map { _ in }
            .drive(getLaunchListAction.inputs)
            .disposed(by: bag)

        input.selectedLaunchesType
            .map { _ in [LaunchListItem]() }
            .drive(launchListRelay)
            .disposed(by: bag)

        input.selectedLaunchesType
            .skip(1)
            .map { _ in }
            .drive(getLaunchListAction.inputs)
            .disposed(by: bag)

        getLaunchListAction.elements
            .withLatestFrom(launchListRelay) { newLaunches, currentLaunches in
                    currentLaunches + newLaunches
                }
            .bind(to: launchListRelay)
            .disposed(by: bag)

        let cells = launchListRelay
            .asDriver()
            .map { [LaunchListSection(items: $0)] }

        let error = getLaunchListAction.errorDriver
        let isLoading = getLaunchListAction.fetchingDriver

        return Output(errors: error,
                      isLoading: isLoading,
                      isPrefetching: isPrefetching,
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
               selectedLaunchesType: Driver<LaunchListDisplayType>) -> LaunchListInput {
        Input(viewDidLoad: viewdDidLoad,
              selectedLaunch: selectedLaunch,
              rowsToPrefetch: rowsToPrefetch,
              selectedLaunchesType: selectedLaunchesType)
    }
}
