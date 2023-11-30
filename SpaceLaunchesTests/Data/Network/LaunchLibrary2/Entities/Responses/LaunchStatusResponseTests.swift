import XCTest

@testable import SpaceLaunches

final class LaunchStatusResponseTests: XCTestCase {

    func test_LaunchStatusResponse_successfullyDecodedWhenValidJSONIsProvided() {
        // Given
        let validJSON = """
            {
                "id": 1,
                "name": "Status",
                "abbrev": "S",
                "description": "Launch Status"
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(LaunchStatusResponse.self, from: Data(validJSON)))
    }

    func test_LaunchStatusResponse_successfullyDecodedWhenAllValuesAreEmpty() {
        // Given
        let jsonWithAllValuesEmpty = """
            {
                "id": 0,
                "name": "",
                "abbrev": "",
                "description": ""
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(LaunchStatusResponse.self, from: Data(jsonWithAllValuesEmpty)))
    }

    func test_LaunchStatusResponse_failsDecodingWhenRequiredKeyIsMissing() {
        // Given
        let jsonWithoutIdKey = """
            {
                "name": "Status",
                "abbrev": "S",
                "description": "Launch Status"
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(LaunchStatusResponse.self, from: Data(jsonWithoutIdKey)))
    }

    func test_LaunchStatusResponse_failsDecodingWhenIdIsNotValidType() {
        // Given
        let jsonWithInvalidId = """
            {
                "id": "not_an_integer",
                "name": "Status",
                "abbrev": "S",
                "description": "Launch Status"
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(LaunchStatusResponse.self, from: Data(jsonWithInvalidId)))
    }
}
