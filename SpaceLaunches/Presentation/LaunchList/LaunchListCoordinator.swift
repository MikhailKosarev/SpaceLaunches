import RxSwift

/// Coordinator responsible for managing the launch list screen flow.
final class LaunchListCoordinator: Coordinator {

    // MARK: - Internal interface

    /// Initializes a new instance of `LaunchListCoordinator`.
    /// - Parameter navigationController: The navigation controller to manage the launch list screen flow.
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    /// Starts the launch list coordinator by presenting the launch list screen.
    func start() {
        guard let viewController = makeViewController() else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }

    /// Navigates to the launch details screen.
    /// - Parameter id: The identifier of the launch to navigate to.
    func navigateToLaunch(id: String) {
        let launchCoordinator = LaunchCoordinator(navigationController: navigationController)
        launchCoordinator.start()
    }

    // MARK: Private interface
    private weak var navigationController: UINavigationController?

    private func makeViewController() -> UIViewController? {
        let launchListViewModel = LaunchListViewModel(service: LaunchLibrary2Service())
        let controller = LaunchListViewController(viewModel: launchListViewModel)

        return controller
    }
}

// MARK: - Rx binders
extension LaunchListCoordinator {
    var navigateToLaunch: Binder<String> {
        Binder(self) { coordinator, id in
            coordinator.navigateToLaunch(id: id)
        }
    }
}
