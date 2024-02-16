@testable import SpaceLaunches

extension LaunchServiceProviderResponse {
    static var stub: LaunchServiceProviderResponse {
        .init(id: 1,
              name: "Provider 1",
              logoURL: nil)
    }
}
