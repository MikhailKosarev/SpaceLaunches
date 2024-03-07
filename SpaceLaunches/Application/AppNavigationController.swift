import UIKit

/// Custom navigation controller for the application.
final class AppNavigationController: UINavigationController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Private Interface

    private func setup() {
        navigationBar.tintColor = .label
        let backButtonBackgroundImage = UIImage(systemName: "chevron.backward.circle")
        let barAppearance = UINavigationBar.appearance()
        barAppearance.backIndicatorImage = backButtonBackgroundImage
        barAppearance.backIndicatorTransitionMaskImage = backButtonBackgroundImage
    }
}
