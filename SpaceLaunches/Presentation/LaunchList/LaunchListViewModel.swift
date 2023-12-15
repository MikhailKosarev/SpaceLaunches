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
