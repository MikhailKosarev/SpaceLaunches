import XCTest

@testable import SpaceLaunches

final class PadResponseTests: XCTestCase {

    func test_PadResponse_successfullyDecodedWhenValidJSONIsProvided() {
        // Given
        let validJSON = """
            {
                "id": 1,
                "latitude": "28.5623",
                "longitude": "-80.5774",
                "location": {
                    "id": 101,
                    "name": "Kennedy Space Center"
                }
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(PadResponse.self, from: Data(validJSON)))
    }

    func test_PadResponse_failsDecodingWhenAllRequiredValuesNull() {
        // Given
        let allNullJSON = """
        {
            "id": null,
            "latitude": null,
            "longitude": null,
            "location": null
        }
        """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(PadResponse.self, from: Data(allNullJSON)))
    }

    func test_PadResponse_failsDecodingWhenKeyIsMissing() {
        // Given
        let jsonWithoutIdKey = """
            {
                "latitude": "28.5623",
                "longitude": "-80.5774",
                "location": {
                    "id": 101,
                    "name": "Kennedy Space Center"
                }
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(PadResponse.self, from: Data(jsonWithoutIdKey)))
    }

    func test_PadResponse_failsDecodingWhenKeyIsNotValidType() {
        // Given
        let jsonWithInvalidId = """
            {
                "id": "not_an_integer",
                "latitude": "28.5623",
                "longitude": "-80.5774",
                "location": {
                    "id": 101,
                    "name": "Kennedy Space Center"
                }
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(PadResponse.self, from: Data(jsonWithInvalidId)))
    }

    func test_PadResponse_successfullyDecodedWithExtraKeys() {
        // Given
        let jsonWithExtraKeys = """
            {
                "id": 1,
                "latitude": "28.5623",
                "longitude": "-80.5774",
                "location": {
                    "id": 101,
                    "name": "Kennedy Space Center"
                },
                "extraKey": "extraValue"
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(PadResponse.self, from: Data(jsonWithExtraKeys)))
    }
}
