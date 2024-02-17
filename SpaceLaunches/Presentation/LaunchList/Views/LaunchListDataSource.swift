import RxDataSources

/// A data source for the launch list table view.
enum LaunchListDataSource {
    /// The data source instance.
    static let dataSource = RxTableViewSectionedReloadDataSource<LaunchListSection>(
        configureCell: { _, tableView, indexPath, item in
            let cell: LaunchListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(item)
            return cell
        },
        titleForHeaderInSection: { dataSource, index in
          dataSource.sectionModels[index].header
        })
}
