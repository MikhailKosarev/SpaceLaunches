import XCTest

@testable import SpaceLaunches

final class RocketConfigurationResponseTests: XCTestCase {

    func test_RocketConfigurationResponse_successfullyDecodedWhenValidJSONIsProvided() {
        // Given
        let validJSON = """
            {
                "id": 1,
                "name": "Falcon 9",
                "image_url": "https://example.com/image"
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(RocketConfigurationResponse.self,
                                                  from: Data(validJSON)))
    }

    func test_RocketConfigurationResponse_failsDecodingWhenAllRequiredValuesNull() {
        // Given
        let allNullJSON = """
        {
            "id": null,
            "name": null,
            "image_url": null
        }
        """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(RocketConfigurationResponse.self,
                                                      from: Data(allNullJSON)))
    }

    func test_RocketConfigurationResponse_failsDecodingWhenKeyIsMissing() {
        // Given
        let jsonWithoutIdKey = """
            {
                "name": "Falcon 9",
                "image_url": "https://example.com/image"
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(RocketConfigurationResponse.self,
                                                      from: Data(jsonWithoutIdKey)))
    }

    func test_RocketConfigurationResponse_failsDecodingWhenKeyIsNotValidType() {
        // Given
        let jsonWithInvalidId = """
            {
                "id": "not_an_integer",
                "name": "Falcon 9",
                "image_url": "https://example.com/image"
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(RocketConfigurationResponse.self,
                                                      from: Data(jsonWithInvalidId)))
    }

}
