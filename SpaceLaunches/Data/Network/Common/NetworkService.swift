import Moya

/// Defines a generic network service.
protocol NetworkService {
    /// The associated type representing the Moya `TargetType` used for network requests.
    associatedtype API: TargetType
    /// The `MoyaProvider` responsible for making network requests.
    var provider: MoyaProvider<API> { get }
}
