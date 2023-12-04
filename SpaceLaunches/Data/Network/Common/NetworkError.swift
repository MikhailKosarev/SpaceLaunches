import Foundation

/// A network-related error that can occur during API requests.
enum NetworkError: Error {
    /// Indicates that the device is not connected to the internet.
    /// Associated with `NSURLErrorNotConnectedToInternet`.
    case noInternetConnection
    /// Indicates that the request to the server took too long to complete.
    /// Associated with `NSURLErrorTimedOut`.
    case timeout
    /// Indicates that the application cannot connect to the server or the server cannot be found.
    /// This can be caused by `NSURLErrorCannotConnectToHost` or `NSURLErrorCannotFindHost`.
    case serverUnreachable
    /// Indicates issues with the SSL/TLS handshake or the server's SSL certificate.
    /// Associated with `NSURLErrorSecureConnectionFailed`, `NSURLErrorServerCertificateHasBadDate`,
    /// and `NSURLErrorServerCertificateUntrusted`.
    case sslError
    /// Indicates that the network connection was lost during the request.
    /// It is recommended to check the internet connection and retry the operation.
    /// Associated with `NSURLErrorNetworkConnectionLost`.
    case networkConnectionLost
    /// Represents any other network error that doesn't fall into the specific categories mentioned above.
    case unknownError
}

// MARK: - LocalizedError
extension NetworkError: LocalizedError {
    /// A localized description for the network error.
    public var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return """
                   The device is not connected to the internet. \
                   Check your device's network settings and ensure an active internet connection.
                   """
        case .timeout:
            return """
                   The request to the server took too long to complete. \
                   Please check your internet connection and try again. \
                   If the issue persists, it may be due to network congestion or server issues, \
                   please contact app support for assistance.
                   """
        case .serverUnreachable:
            return """
                   The application cannot connect to the server or the server cannot be found. \
                   Check your internet connection and try again. If the issue persists, \
                   the server may be temporarily unavailable, please try again later.
                   """
        case .sslError:
            return """
                   There are some issues during the network request. \
                   Ensure your device's date and time settings are correct. \
                   If the issue persists, it may be a server-side problem. \
                   Please contact app support for assistance.
                   """
        case .networkConnectionLost:
            return """
                   The network connection was lost during the request. \
                   Check your internet connection and try again. \
                   If using cellular data, ensure you have a stable signal.
                   """
        case .unknownError:
            return """
                   An unexpected error occurred. Try the operation again. \
                   If the issue persists, please contact app support for assistance.
                   """
        }
    }
}
