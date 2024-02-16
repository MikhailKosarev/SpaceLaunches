@testable import SpaceLaunches

extension LaunchListResponse {
    static func stub(numberOfLaunches: Int) -> LaunchListResponse {
        LaunchListResponse(count: numberOfLaunches,
                           next: nil,
                           previous: nil,
                           results: Array(repeating: LaunchResponse.stub, count: numberOfLaunches))
    }
}
