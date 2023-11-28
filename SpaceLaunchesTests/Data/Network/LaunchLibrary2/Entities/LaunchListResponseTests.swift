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
}
