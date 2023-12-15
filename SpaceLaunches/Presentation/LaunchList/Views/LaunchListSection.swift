import RxDataSources

/// A section for the table view containing the launch list.
struct LaunchListSection {

    /// Header title for the section.
    var header: String = "Launches"
    /// Items within the section.
    var items: [Item]
}

// MARK: - SectionModelType
extension LaunchListSection: SectionModelType {

    /// Type of items within the section.
    typealias Item = LaunchListItem

    /// Initializes a section with items.
    /// - Parameters:
    ///   - original: The original section to duplicate.
    ///   - items: The items to populate the section.
    init(original: LaunchListSection, items: [Item]) {
        self = original
        self.items = items
    }
}
