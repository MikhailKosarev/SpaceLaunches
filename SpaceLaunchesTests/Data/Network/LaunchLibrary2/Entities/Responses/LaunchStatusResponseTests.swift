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
}
