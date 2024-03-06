import UIKit

/// View controller to display detailed information about the launch.
final class LaunchViewController: UIViewController {

    // MARK: - Private properties
    private var viewModel: LaunchViewModelType

    // MARK: - Initialization
    init(viewModel: LaunchViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        view.backgroundColor = .yellow
    }
}
