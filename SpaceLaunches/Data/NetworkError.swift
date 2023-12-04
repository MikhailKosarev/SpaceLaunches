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
