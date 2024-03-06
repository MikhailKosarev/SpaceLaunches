import UIKit

/// Coordinator responsible for managing the launch screen flow.
final class LaunchCoordinator: Coordinator {

    // MARK: - Internal interface

    /// Initializes a new instance of `LaunchCoordinator`.
    /// - Parameter navigationController: The navigation controller to manage the launch screen flow.
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    /// Starts the launch coordinator by presenting the launch screen.
    func start() {
        guard let viewController = makeViewController() else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }

// MARK: Private interface

    private weak var navigationController: UINavigationController?

    private func makeViewController() -> UIViewController? {
        let launchViewModel = LaunchViewModel()
        let viewController = LaunchViewController()

        return viewController
    }
}
