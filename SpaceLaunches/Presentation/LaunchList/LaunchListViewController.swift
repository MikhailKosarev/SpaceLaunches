import RxCocoa
import RxDataSources
import RxSwift
import SnapKit
import UIKit

/// View controller for displaying a list of launches.
final class LaunchListViewController: UIViewController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

    // MARK: - Private interface
    private let bag = DisposeBag()
    private var viewModel: LaunchListViewModelType
    private let launchListDataSource = LaunchListDataSource.dataSource

    }
}
