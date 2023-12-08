/// A type of launch list that can be display.
enum LaunchListDisplayType: Int, CaseIterable {

    // MARK: - Internal interface
    /// Indicates upcoming launches.
    case upcoming
    /// Indicates previous launches.
    case previous
    /// Indicates all launches.
    case all

    /// The title associated with each type.
    var title: String {
        switch self {
        case .upcoming: return Constants.upcomingTitle
        case .previous: return Constants.previousTitle
        case .all: return Constants.allTitle
        }
    }

    // MARK: - Private interface
    private enum Constants {
        static let upcomingTitle = "Upcoming"
        static let previousTitle = "Previous"
        static let allTitle = "All"
    }
}
