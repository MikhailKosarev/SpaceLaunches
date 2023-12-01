import XCTest

@testable import SpaceLaunches

final class LaunchServiceProviderResponseTests: XCTestCase {

    func test_LaunchServiceProviderResponse_successfullyDecodedWhenValidJSONIsProvided() {
        // Given
        let validJSON = """
            {
                "id": 1,
                "name": "Provider 1",
                "logo_url": "https://example.com/logo"
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(LaunchServiceProviderResponse.self, from: Data(validJSON)))
    }
}
