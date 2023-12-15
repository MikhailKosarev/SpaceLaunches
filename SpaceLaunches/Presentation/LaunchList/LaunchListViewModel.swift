import RxCocoa
import RxSwift

/// View model for managing the launch list.
final class LaunchListViewModel {

    // MARK: - Private interface
    /// Dispose bag to store subscriptions.
    private let bag = DisposeBag()
    /// Service for fetching launch data.
    private let service: LaunchLibrary2Service
    /// Use case for getting the launch list.
    private let getLaunchListUseCase: GetLaunchListUseCase
    /// Relay for holding the sections of the launch list.
    private let cellsRelay = BehaviorRelay<[LaunchListSection]>(value: [])
    /// Relay for holding the list of launches.
    private let launchListRelay = BehaviorRelay<[LaunchListItem]>(value: [])
    /// Number of items to load initially.
    private let numberOfItemsToLoad = 20
    /// Number of items to prefetch.
    private let numberOfItemsToPrefetch = 10

    // MARK: - Initialization
    /// Initializes the launch list view model.
    /// - Parameter service: Service for fetching launch data.
    init(service: LaunchLibrary2Service) {
        self.service = service
        getLaunchListUseCase = GetLaunchListUseCase(service: service)
    }
}

// MARK: - LaunchListViewModelType
extension LaunchListViewModel: LaunchListViewModelType {

    /// The input for the launch list view model.
    struct Input: LaunchListInput {
        let viewdDidLoad: Driver<Void>
        let selectedLaunch: Driver<LaunchListItem>
        let rowsToPrefetch: Driver<[Int]>
        let selectedLaunchesType: Driver<LaunchListDisplayType>
    }

    /// The output for the launch list view model.
    struct Output: LaunchListOutput {
        let errors: Driver<Error>
        let isLoading: Driver<Bool>
        let cells: Driver<[LaunchListSection]>
    }

    func transform(input: LaunchListInput) -> LaunchListOutput {
        let requestOffset = launchListRelay
            .asDriver()
            .map { $0.count }

        let limit = launchListRelay
            .asDriver()
            .map { [weak self] in
                guard let self else { return 0 }
                return $0.isEmpty ? self.numberOfItemsToLoad : self.numberOfItemsToPrefetch
            }

        let getLaunchListAction = getLaunchListUseCase.produce(
            input: (GetLaunchListUseCase.Input(type: input.selectedLaunchesType,
                                               limit: limit,
                                               offset: requestOffset))
        )

        input.viewdDidLoad
            .drive(getLaunchListAction.inputs)
            .disposed(by: bag)

        input.rowsToPrefetch
            .filter { [weak self] in
                guard let self else { return false }
                return $0.contains(self.launchListRelay.value.count - 2) }
            .map { _ in }
            .drive(getLaunchListAction.inputs)
            .disposed(by: bag)

        input.selectedLaunchesType.skip(1)
            .do(onNext: { [weak self] _ in
                self?.cellsRelay.accept([])
                self?.launchListRelay.accept([])
            })
            .map { _ in }
            .drive(getLaunchListAction.inputs)
            .disposed(by: bag)

        getLaunchListAction.elementsDriver
            .withLatestFrom(launchListRelay.asDriver()) { newItems, currentItems in
                    currentItems + newItems
                }
            .drive(launchListRelay)
            .disposed(by: bag)

        launchListRelay
            .map { [LaunchListSection(items: $0)] }
            .bind(to: cellsRelay)
            .disposed(by: bag)

        let error = getLaunchListAction.errorDriver
        let isLoading = getLaunchListAction.fetchingDriver

        return Output(errors: error,
                      isLoading: isLoading,
                      cells: cellsRelay.asDriver())
    }

    func input(viewdDidLoad: Driver<Void>,
               selectedLaunch: Driver<LaunchListItem>,
               rowsToPrefetch: Driver<[Int]>,
               selectedLaunchesType: Driver<LaunchListDisplayType>) -> LaunchListInput {
        Input(viewdDidLoad: viewdDidLoad,
              selectedLaunch: selectedLaunch,
              rowsToPrefetch: rowsToPrefetch,
              selectedLaunchesType: selectedLaunchesType)
    }
}
