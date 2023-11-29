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

// MARK: - TargetType
extension LaunchLibrary2API: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        Credentials.LaunchLibrary2.baseURL
    }
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .getLaunchList(let type, _):
            return "launch/\(type.rawValue)"
        case .getLaunch(let id):
            return "launch/\(id)"
        }
    }
    /// The HTTP method used in the request.
    var method: Method {
        switch self {
        case .getLaunchList, .getLaunch:
            return .get
        }
    }
    /// The type of HTTP task to be performed.
    var task: Task {
        switch self {
        case .getLaunchList(_, let parameters):
            return .requestParameters(parameters: ["limit": parameters.limit,
                                                   "offset": parameters.offset,
                                                   "mode": parameters.mode, ],
                                      encoding: URLEncoding.default)
        case .getLaunch:
            return .requestPlain
        }
    }
    /// The headers to be used in the request.
    var headers: [String: String]? {
        nil
    }
}
