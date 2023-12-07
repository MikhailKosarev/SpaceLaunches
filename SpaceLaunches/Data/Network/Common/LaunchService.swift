import RxSwift

/// Defines methods for interacting with launch-related data.
protocol LaunchService {
    /// Retrieves a list of launches based on the specified parameters.
    ///
    /// - Parameters:
    ///   - type: The type of launch list to fetch, such as upcoming or previous launches.
    ///   - parameters: Parameters for refining the request.
    ///
    /// - Returns: A `Single` emitting a `LaunchListResponse` upon successful retrieval.
    func getLaunchList(type: LaunchListNetworkType,
                       parameters: GetLaunchListRequestParameters) -> Single<LaunchListResponse>
    /// Retrieves detailed information about a specific launch.
    ///
    /// - Parameter id: The identifier of the launch to retrieve.
    ///
    /// - Returns: A `Single` emitting a `LaunchResponse` upon successful retrieval.
    func getLaunch(_ id: String) -> Single<LaunchResponse>
}
