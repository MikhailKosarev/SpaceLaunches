import Moya
import RxSwift

/// Defines a generic network service.
protocol NetworkService {
    /// The associated type representing the Moya `TargetType` used for network requests.
    associatedtype API: TargetType
    /// The `MoyaProvider` responsible for making network requests.
    var provider: MoyaProvider<API> { get }
}

// MARK: - Default implementation
extension NetworkService {
    /// Makes a network request and returns a `Single` containing the decoded response or an `NetworkError`.
    ///
    /// - Parameters:
    ///   - request: The request to be executed.
    /// - Returns: A `Single` containing either the decoded response or a `NetworkError`.
    func fetchDecodedData<T: Decodable>(_ request: API) -> Single<T> {
        return provider.rx
            .request(request)
            .filterSuccessfulStatusCodes()
            .map(T.self)
            .catch { throw mapToNetworkError($0) }
    }
    /// Maps Moya errors to a custom `NetworkError`.
    ///
    /// - Parameter error: The `Moya` error to be mapped.
    /// - Returns: A `NetworkError` representing the mapped error.
    private func mapToNetworkError(_ error: Error) -> NetworkError {
        guard let moyaError = error as? MoyaError else { return .unknownError }
        switch moyaError {
        case .underlying(let underlyingError, _):
            return mapUnderlyingError(underlyingError)
        default:
            return .unknownError
        }
    }
    /// Maps underlying Moya errors to a custom `NetworkError`.
    ///
    /// - Parameter error: The underlying error to be mapped.
    /// - Returns: A `NetworkError` representing the mapped error.
    private func mapUnderlyingError(_ error: Error) -> NetworkError {
        guard let error = error.asAFError?.underlyingError as? NSError else {
            return .unknownError
        }

        switch error.code {
        case NSURLErrorNotConnectedToInternet:
            return .noInternetConnection
        case NSURLErrorTimedOut:
            return .timeout
        case NSURLErrorCannotConnectToHost, NSURLErrorCannotFindHost:
            return .serverUnreachable
        case NSURLErrorSecureConnectionFailed, NSURLErrorServerCertificateHasBadDate,
        NSURLErrorServerCertificateUntrusted:
            return .sslError
        case NSURLErrorNetworkConnectionLost:
            return .networkConnectionLost
        default:
            return .unknownError
        }
    }
}
