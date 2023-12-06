import Moya

@testable import SpaceLaunches

/// A mock implementation of the `NetworkService` protocol for testing purposes.
///
/// This class serves as a mock network service that conforms to the `NetworkService` protocol,
/// allowing you to substitute it in tests and control the behavior of network requests.
///
///  - Warning: Do not use this class in a production environment. 
///  It is specifically designed for testing purposes only.
final class MockNetworkService: NetworkService {
    /// The associated type representing the Moya TargetType used for network requests.
    typealias API = MockAPI
    /// The MoyaProvider responsible for making network requests with the mock API.
    let provider: MoyaProvider<API>
    /// Initializes a new instance of the `MockNetworkService` class.
    ///
    /// Use this initializer to create a `MockNetworkService` instance with a specific `MoyaProvider` configuration.
    ///
    /// - Parameter provider: The `MoyaProvider` responsible for making network requests with the mock API.
    /// - Warning: Do not use this class in a production environment. 
    /// It is specifically designed for testing purposes only.
    init(provider: MoyaProvider<API>) {
        self.provider = provider
    }
}
