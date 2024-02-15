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
        let cells: Driver<[LaunchListSection]>
    }

    func transform(input: LaunchListInput) -> LaunchListOutput {
        let requestOffset = launchListRelay
            .asDriver()
            .map { $0.count }

        let limit = launchListRelay
            .asDriver()
            .map { $0.isEmpty ? numberOfLaunchesToLoad : numberOfLaunchesToPrefetch
            }

        let getLaunchListAction = getLaunchListUseCase.produce(
            input: (GetLaunchListUseCase.Input(type: input.selectedLaunchesType,
                                               limit: limit,
                                               offset: requestOffset))
        )

        input.viewDidLoad
            .drive(getLaunchListAction.inputs)
            .disposed(by: bag)

        input.rowsToPrefetch
            .filter { $0.contains(launchListRelay.value.count - 2) }
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

        getLaunchListAction.elementsDriver
            .withLatestFrom(launchListRelay.asDriver()) { newLaunches, currentLaunches in
                    currentLaunches + newLaunches
                }
            .drive(launchListRelay)
            .disposed(by: bag)

        let cells = launchListRelay
            .asDriver()
            .map { [LaunchListSection(items: $0)] }

        let error = getLaunchListAction.errorDriver
        let isLoading = getLaunchListAction.fetchingDriver

        return Output(errors: error,
                      isLoading: isLoading,
                      cells: cells)
    }

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
