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

    func test_LaunchServiceProviderResponse_failsDecodingWhenAllRequiredValuesNull() {
        // Given
        let allNullJSON = """
            {
                "id": null,
                "name": null
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(LaunchServiceProviderResponse.self, from: Data(allNullJSON)))
    }

    func test_LaunchServiceProviderResponse_failsDecodingWhenKeyIsMissing() {
        // Given
        let jsonWithoutId = """
            {
                "name": "Provider 1",
                "logo_url": "https://example.com/logo"
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(LaunchServiceProviderResponse.self, from: Data(jsonWithoutId)))
    }

    func test_LaunchServiceProviderResponse_failsDecodingKeyIsNotValidType() {
        // Given
        let jsonWithInvalidId = """
            {
                "id": "not_an_integer",
                "name": "Provider 1",
                "logo_url": "https://example.com/logo"
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(LaunchServiceProviderResponse.self,
                                                      from: Data(jsonWithInvalidId)))
    }

    func test_LaunchServiceProviderResponse_successfullyDecodedWithExtraKeys() {
        // Given
        let jsonWithExtraKeys = """
            {
                "id": 1,
                "name": "Provider 1",
                "logo_url": "https://example.com/logo",
                "extraKey": "extraValue"
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(LaunchServiceProviderResponse.self,
                                                      from: Data(jsonWithExtraKeys)))
    }
}
