import XCTest

@testable import SpaceLaunches

final class LaunchListResponseTests: XCTestCase {

    func test_LaunchListResponse_successfullyDecodedWhenValidJSONIsProvided() {
        // Given
        let validJSON = """
            {
                "count": 2,
                "next": "https://example.com/next",
                "previous": "https://example.com/previous",
                "results": [
                    {"id": "1", "name": "Launch 1"},
                    {"id": "2", "name": "Launch 2"}
                ]
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(LaunchListResponse.self, from: Data(validJSON)))
    }

    func test_LaunchListResponse_failsDecodingWhenAllRequiredValuesNull() {
        // Given
        let allNullJSON = """
        {
            "count": null,
            "next": null,
            "previous": null,
            "results": null
        }
        """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(LaunchListResponse.self, from: Data(allNullJSON)))
    }

    func test_LaunchListResponse_failsDecodingWhenKeyIsMissing() {
        // Given
        let jsonWithoutCountKey = """
            {
                "next": "https://example.com/next",
                "previous": "https://example.com/previous",
                "results": [
                    {"id": "1", "name": "Launch 1"},
                    {"id": "2", "name": "Launch 2"}
                ]
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(LaunchListResponse.self, from: Data(jsonWithoutCountKey)))
    }

    func test_LaunchListResponse_failsDecodingWhenKeyIsNotValidType() {
        // Given
        let jsonWithInvalidCount = """
            {
                "count": "not_an_integer",
                "next": "https://example.com/next",
                "previous": "https://example.com/previous",
                "results": [
                    {"id": "1", "name": "Launch 1"},
                    {"id": "2", "name": "Launch 2"}
                ]
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(LaunchListResponse.self, from: Data(jsonWithInvalidCount)))
    }

    func test_LaunchListResponse_successfullyDecodedWithExtraKeys() {
        // Given
        let jsonWithExtraKeys = """
            {
                "count": 2,
                "next": "https://example.com/next",
                "previous": "https://example.com/previous",
                "results": [
                    {"id": "1", "name": "Launch 1"},
                    {"id": "2", "name": "Launch 2"}
                ],
                "extraKey": "extraValue"
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(LaunchListResponse.self, from: Data(jsonWithExtraKeys)))
    }
}
