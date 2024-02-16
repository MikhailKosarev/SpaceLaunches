import Foundation

@testable import SpaceLaunches

extension LaunchListItem {
    static var stub: LaunchListItem {
        .init(id: "1",
              imageURL: URL(string: "https://example.com/image.jpg"),
              name: "Launch 1",
              net: "Launch date is unknown",
              launchServiceProvider: "Provider 1",
              location: "Pad 1")
    }
}
