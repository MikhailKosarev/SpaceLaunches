@testable import SpaceLaunches

extension PadResponse {
    static var stub: PadResponse {
        .init(id: 1,
              latitude: nil,
              longitude: nil,
              location: LocationResponse.stub)
    }
}
