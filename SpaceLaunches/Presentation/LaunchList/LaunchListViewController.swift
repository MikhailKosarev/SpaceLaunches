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

    // MARK: UI elements
    private lazy var launchListTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(cellType: LaunchListTableViewCell.self)
        tableView.rx.itemSelected.bind { [weak self] in
            tableView.deselectRow(at: $0, animated: true)
        }.disposed(by: bag)
        return tableView
    }()

    private lazy var launchesTypeSegmentedControl: UISegmentedControl = {
        let items = LaunchListDisplayType.allCases.map { $0.title }
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = LaunchListDisplayType.upcoming.rawValue
        return segmentedControl
    }()

    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
}
    }
}
