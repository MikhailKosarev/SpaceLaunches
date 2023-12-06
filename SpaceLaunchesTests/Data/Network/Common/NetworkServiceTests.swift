import Alamofire
import Moya
import RxSwift
import RxTest
import XCTest

@testable import SpaceLaunches

final class NetworkServiceTests: XCTestCase {

    typealias MockAPIProvider = MoyaProvider<MockAPI>

    // MARK: - Setup and Teardown
    override func setUp() {
      super.setUp()
      scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
      scheduler.scheduleAt(300) {
        self.subscription.dispose()
      }
      scheduler = nil
      super.tearDown()
    }

    // MARK: - Test Cases
    func test_fetchDecodedData_EmitsDecodedDataWhenResponseStatusIsSuccessful() throws {
        // Given
        let (decodedData, responseData) = try XCTUnwrap(makeStubData())
        let stubProvider = makeStubProvider(responseCode: 200, responseData: responseData)
        let networkService = MockNetworkService(provider: stubProvider)

        // When
        let result: TestableObserver<MockResponseData> = scheduler.start {
            networkService.fetchDecodedData(.testRequest)
        }

        // Then
        XCTAssertEqual(result.events, [
            .next(200, decodedData),
            .completed(200),
        ])
    }

    func test_fetchDecodedData_EmitsNoInternetConnectionErrorWhenSessionTaskFailedWithNoInternetConnectionError() {
        // Given
        let error = AFError.sessionTaskFailed(error: NSError(domain: "NSURLErrorDomain",
                                                             code: NSURLErrorNotConnectedToInternet))
        let stubProvider = makeStubProvider(responseError: error as NSError)
        let networkService = MockNetworkService(provider: stubProvider)

        // When
        let result: TestableObserver<MockResponseData> = scheduler.start {
            networkService.fetchDecodedData(.testRequest)
        }

        // Then
        XCTAssertEqual(result.events, [
            .error(200, NetworkError.noInternetConnection)
        ])
    }

    func test_fetchDecodedData_EmitsTimeoutErrorWhenSessionTaskFailedWithTimeoutError() {
        // Given
        let error = AFError.sessionTaskFailed(error: NSError(domain: "NSURLErrorDomain",
                                                             code: NSURLErrorTimedOut))
        let stubProvider = makeStubProvider(responseError: error as NSError)
        let networkService = MockNetworkService(provider: stubProvider)

        // When
        let result: TestableObserver<MockResponseData> = scheduler.start {
            networkService.fetchDecodedData(.testRequest)
        }

        // Then
        XCTAssertEqual(result.events, [
            .error(200, NetworkError.timeout)
        ])
    }

    func test_fetchDecodedData_EmitsServerUnreachableErrorWhenSessionTaskFailedWithServerUnreachableError() {
        // Given
        let error = AFError.sessionTaskFailed(error: NSError(domain: "NSURLErrorDomain",
                                                             code: NSURLErrorCannotConnectToHost))
        let stubProvider = makeStubProvider(responseError: error as NSError)
        let networkService = MockNetworkService(provider: stubProvider)

        // When
        let result: TestableObserver<MockResponseData> = scheduler.start {
            networkService.fetchDecodedData(.testRequest)
        }

        // Then
        XCTAssertEqual(result.events, [
            .error(200, NetworkError.serverUnreachable)
        ])
    }

    func test_fetchDecodedData_EmitsSSLErrorWhenSessionTaskFailedWithSSLError() {
        // Given
        let error = AFError.sessionTaskFailed(error: NSError(domain: "NSURLErrorDomain",
                                                             code: NSURLErrorSecureConnectionFailed))
        let stubProvider = makeStubProvider(responseError: error as NSError)
        let networkService = MockNetworkService(provider: stubProvider)

        // When
        let result: TestableObserver<MockResponseData> = scheduler.start {
            networkService.fetchDecodedData(.testRequest)
        }

        // Then
        XCTAssertEqual(result.events, [
            .error(200, NetworkError.sslError)
        ])
    }

    func test_fetchDecodedData_EmitsNetworkConnectionLostErrorWhenSessionTaskFailedWithNetworkConnectionLostError() {
        // Given
        let error = AFError.sessionTaskFailed(error: NSError(domain: "NSURLErrorDomain",
                                                             code: NSURLErrorNetworkConnectionLost))
        let stubProvider = makeStubProvider(responseError: error as NSError)
        let networkService = MockNetworkService(provider: stubProvider)

        // When
        let result: TestableObserver<MockResponseData> = scheduler.start {
            networkService.fetchDecodedData(.testRequest)
        }

        // Then
        XCTAssertEqual(result.events, [
            .error(200, NetworkError.networkConnectionLost)
        ])
    }

    func test_fetchDecodedData_EmitsUnknownErrorWhenSessionTaskFailedWithUnknownError() {
        // Given
        let error = AFError.sessionTaskFailed(error: NSError(domain: "SomeErrorDomain", code: 123))
        let stubProvider = makeStubProvider(responseError: error as NSError)
        let networkService = MockNetworkService(provider: stubProvider)

        // When
        let result: TestableObserver<MockResponseData> = scheduler.start {
            networkService.fetchDecodedData(.testRequest)
        }

        // Then
        XCTAssertEqual(result.events, [
            .error(200, NetworkError.unknownError)
        ])
    }

    func test_fetchDecodedData_EmitsInformationalErrorWhenResponseStatusIs100() {
        // Given
        let stubProvider = makeStubProvider(responseCode: 100, responseData: Data())
        let networkService = MockNetworkService(provider: stubProvider)

        // When
        let result: TestableObserver<MockResponseData> = scheduler.start {
            networkService.fetchDecodedData(.testRequest)
        }

        // Then
        XCTAssertEqual(result.events, [
            .error(200, NetworkError.unknownError) // Adjust based on your error handling logic
        ])
    }

    func test_fetchDecodedData_EmitsRedirectionErrorWhenResponseStatusIs300() {
        // Given
        let stubProvider = makeStubProvider(responseCode: 300, responseData: Data())
        let networkService = MockNetworkService(provider: stubProvider)

        // When
        let result: TestableObserver<MockResponseData> = scheduler.start {
            networkService.fetchDecodedData(.testRequest)
        }

        // Then
        XCTAssertEqual(result.events, [
            .error(200, NetworkError.unknownError) // Adjust based on your error handling logic
        ])
    }

    func test_fetchDecodedData_EmitsUknownErrorWhenResponseStatusIs400() {
        // Given
        let stubProvider = makeStubProvider(responseCode: 400, responseData: Data())
        let networkService = MockNetworkService(provider: stubProvider)

        // When
        let result: TestableObserver<MockResponseData> = scheduler.start {
            networkService.fetchDecodedData(.testRequest)
        }

        // Then
        XCTAssertEqual(result.events, [
            .error(200, NetworkError.unknownError)
        ])
    }

    func test_fetchDecodedData_EmitsUknownErrorWhenResponseStatusIs500() {
            // Given
            let stubProvider = makeStubProvider(responseCode: 500, responseData: Data())
            let networkService = MockNetworkService(provider: stubProvider)

            // When
            let result: TestableObserver<MockResponseData> = scheduler.start {
                networkService.fetchDecodedData(.testRequest)
            }

            // Then
            XCTAssertEqual(result.events, [
                .error(200, NetworkError.unknownError)
            ])
        }

    // MARK: - Helper properties and methods
    private var scheduler: TestScheduler!
    private var subscription: Disposable!

    private func makeStubProvider(responseCode: Int,
                                  responseData: Data) -> MockAPIProvider {
        let successfulResponse = EndpointSampleResponse.networkResponse(responseCode,
                                                                        responseData)
        let stubClosure: (MockAPI) -> Endpoint = { target in
            Endpoint(url: URL(target: target).absoluteString,
                     sampleResponseClosure: { successfulResponse },
                     method: target.method,
                     task: target.task,
                     httpHeaderFields: target.headers)
        }

        let stubProvider = MoyaProvider<MockAPI>(endpointClosure: stubClosure,
                                                 stubClosure: MoyaProvider.immediatelyStub)

        return stubProvider
    }

    private func makeStubProvider(responseError: NSError) -> MockAPIProvider {
        let errorResponse = EndpointSampleResponse.networkError(responseError)
        let stubClosure: (MockAPI) -> Endpoint = { target in
            Endpoint(url: URL(target: target).absoluteString,
                     sampleResponseClosure: { errorResponse },
                     method: target.method,
                     task: target.task,
                     httpHeaderFields: target.headers)
        }

        let stubProvider = MoyaProvider<MockAPI>(endpointClosure: stubClosure,
                                                 stubClosure: MoyaProvider.immediatelyStub)

        return stubProvider
    }

    private func makeStubData() throws -> (decoded: MockResponseData, encoded: Data) {
        let decodedData = MockResponseData()
        let encodedData = try JSONEncoder().encode(decodedData)
        return (decodedData, encodedData)
    }
}
