import Foundation

/// A representation of a launch item with essential information.
struct LaunchListItem: Equatable {

    /// The unique identifier for the launch item.
    let id: String
    /// The URL for the launch item's image, if available.
    let imageURL: URL?
    /// The name of the launch item.
    let name: String
    /// The formatted launch date and time string.
    let net: String
    /// The name of the launch service provider or a default value if unknown.
    let launchServiceProvider: String
    /// The name of the launch location or a default value if unknown.
    let location: String
}
