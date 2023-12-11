import XCTest

@testable import SpaceLaunches

final class OrbitResponseTests: XCTestCase {

    func test_OrbitResponse_successfullyDecodedWhenValidJSONIsProvided() {
        // Given
        let validJSON = """
            {
                "id": 1,
                "name": "Low Earth Orbit",
                "abbrev": "LEO"
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(OrbitResponse.self, from: Data(validJSON)))
    }

    func test_OrbitResponse_failsDecodingWhenAllRequiredValuesNull() {
        // Given
        let allNullJSON = """
        {
            "id": null,
            "name": null,
            "abbrev": null
        }
        """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(OrbitResponse.self, from: Data(allNullJSON)))
    }

    func test_OrbitResponse_failsDecodingWhenKeyIsMissing() {
        // Given
        let jsonWithoutIdKey = """
            {
                "name": "Low Earth Orbit",
                "abbrev": "LEO"
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(OrbitResponse.self, from: Data(jsonWithoutIdKey)))
    }

    func test_OrbitResponse_failsDecodingWhenKeyIsNotValidType() {
        // Given
        let jsonWithInvalidId = """
            {
                "id": "not_an_integer",
                "name": "Low Earth Orbit",
                "abbrev": "LEO"
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(OrbitResponse.self, from: Data(jsonWithInvalidId)))
    }

    func test_OrbitResponse_successfullyDecodedWithExtraKeys() {
        // Given
        let jsonWithExtraKeys = """
            {
                "id": 1,
                "name": "Low Earth Orbit",
                "abbrev": "LEO",
                "extraKey": "extraValue"
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(OrbitResponse.self, from: Data(jsonWithExtraKeys)))
    }
}
