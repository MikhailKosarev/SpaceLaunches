@testable import SpaceLaunches

extension LaunchResponse {
    static var stub: LaunchResponse {
        .init(id: "1",
              name: "Launch 1",
              status: nil,
              net: "2023-01-01",
              launchServiceProvider: .stub,
              rocket: nil,
              mission: nil,
              pad: .stub,
              image: "https://example.com/image.jpg")
    }
}
