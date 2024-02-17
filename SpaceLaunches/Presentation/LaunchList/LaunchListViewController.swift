import RxCocoa
import RxDataSources
import RxSwift
import SnapKit
import UIKit

/// View controller for displaying a list of launches.
final class LaunchListViewController: UIViewController {

    // MARK: - Initialization

    /// Initializes the launch list view controller with a view model.
    /// - Parameter viewModel: The view model for the launch list.
    init(viewModel: LaunchListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }

    /// Required initializer, not implemented.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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

// MARK: - Setup
extension LaunchListViewController {

    private func addSubviews() {
        view.addSubview(launchListTableView)
        view.addSubview(launchesTypeSegmentedControl)
        view.addSubview(activityIndicatorView)
    }

    private func setup() {
        view.backgroundColor = .systemBackground
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButton
    }

    private func setConstraints() {
        launchListTableView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(launchesTypeSegmentedControl.snp.top)
        }

        launchesTypeSegmentedControl.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: Binding
extension LaunchListViewController {

    private func bind() {
        let input = getInput(for: viewModel)
        let output = viewModel.transform(input: input)

        output.cells
            .drive(launchListTableView.rx.items(dataSource: launchListDataSource))
            .disposed(by: bag)

        output.isLoading
            .drive(activityIndicatorView.rx.isAnimating).disposed(by: bag)
    }

    private func getInput(for viewModel: LaunchListViewModelType) -> LaunchListInput {
        let selectedLaunchesType = launchesTypeSegmentedControl.rx.selectedSegmentIndex
            .asDriver()
            .compactMap { LaunchListDisplayType(rawValue: $0) }

        return viewModel.input(viewdDidLoad: rx.viewDidLoad.asDriver(),
                        selectedLaunch: launchListTableView.rx.modelSelected(LaunchListItem.self).asDriver(),
                        rowsToPrefetch: launchListTableView.rx.prefetchRows.asDriver().map { $0.map(\.row) },
                        selectedLaunchesType: selectedLaunchesType)
    }
}
