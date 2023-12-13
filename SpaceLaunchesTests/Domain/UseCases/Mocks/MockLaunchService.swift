import RxSwift

@testable import SpaceLaunches

/// A mock implementation of the `LaunchService` protocol for testing purposes.
final class MockLaunchService: LaunchService {
    /// A stub for the `getLaunchList` method.
    var getLaunchListStub: Single<LaunchListResponse>?
    /// A stub for the `getLaunch` method.
    var getLaunchStub: Single<LaunchResponse>?

    /// Retrieves a list of launches based on the specified network type and request parameters.
    /// - Parameters:
    ///   - type: The type of the launch list network request.
    ///   - parameters: The parameters for the launch list request.
    /// - Returns: `getLaunchListStub` regardless of the input parameters.
    func getLaunchList(type: LaunchListNetworkType,
                       parameters: GetLaunchListRequestParameters) -> Single<LaunchListResponse> {
        getLaunchListStub!
    }
    /// Retrieves details of a specific launch identified by its ID.
    /// - Parameter id: The ID of the launch.
    /// - Returns: `getLaunchStub` regardless of the input parameters.
    func getLaunch(_ id: String) -> Single<LaunchResponse> {
        getLaunchStub!
    }
}
