import XCTest

@testable import SpaceLaunches

final class RocketResponseTests: XCTestCase {

    func test_RocketResponse_successfullyDecodedWhenValidJSONIsProvided() {
        // Given
        let validJSON = """
            {
                "id": 1,
                "configuration": {
                    "id": 1,
                    "name": "Falcon 9",
                    "image_url": "https://example.com/image"
                }
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(RocketResponse.self, from: Data(validJSON)))
    }

    func test_RocketResponse_failsDecodingWhenAllRequiredValuesNull() {
        // Given
        let allNullJSON = """
        {
            "id": null,
            "configuration": null
        }
        """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(RocketResponse.self, from: Data(allNullJSON)))
    }

    func test_RocketResponse_failsDecodingWhenKeyIsMissing() {
        // Given
        let jsonWithoutIdKey = """
            {
                "configuration": {
                    "id": 1,
                    "name": "Falcon 9",
                    "image_url": "https://example.com/image"
                }
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(RocketResponse.self, from: Data(jsonWithoutIdKey)))
    }

    func test_RocketResponse_failsDecodingKeyIsNotValidType() {
        // Given
        let jsonWithInvalidId = """
            {
                "id": "not_an_integer",
                "configuration": {
                    "id": 1,
                    "name": "Falcon 9",
                    "image_url": "https://example.com/image"
                }
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(RocketResponse.self, from: Data(jsonWithInvalidId)))
    }

}
