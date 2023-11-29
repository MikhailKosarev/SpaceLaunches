import Moya

/// An API target that provides implementation details and is further transformed into a full request.
enum LaunchLibrary2API {
    /// Retrieves a list of launches.
    ///
    /// - Parameters:
    ///   - type: The type of launch list to retrieve.
    ///   - parameters: Additional parameters for the request.
    case getLaunchList(type: LaunchListNetworkType, parameters: GetLaunchListRequestParameters)
    /// Retrieves detailed information about a specific launch.
    ///
    /// - Parameter id: The identifier of the launch.
    case getLaunch(id: String)
}
