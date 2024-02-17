import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = getLaunchListViewController()
    }

    private func getLaunchListViewController() -> LaunchListViewController {
        let launchService = LaunchLibrary2Service()
        let viewModel = LaunchListViewModel(service: launchService)
        let viewController = LaunchListViewController(viewModel: viewModel)
        return viewController
    }
}
