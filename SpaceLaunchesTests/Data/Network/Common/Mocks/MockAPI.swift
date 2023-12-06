import Moya

/// A mock API target that provides implementation details to mock network requests
/// when testing components that rely on Moya providers.
///
/// - Warning: Do not use this case in a production environment. It is specifically designed for testing purposes only.
enum MockAPI: TargetType {
    /// Represents a test request.
    case testRequest
    /// The base URL for the mock API.
    var baseURL: URL {
        return URL(string: "https://api.testapi.com")!
    }
    /// The path for the network request.
    var path: String {
        return "/path"
    }
    /// The HTTP method for the network request.
    var method: Moya.Method {
        return .get
    }
    /// The task to be performed.
    var task: Task {
        return .requestPlain
    }
    /// The HTTP headers for the network request.
    var headers: [String: String]? {
        return nil
    }
}
