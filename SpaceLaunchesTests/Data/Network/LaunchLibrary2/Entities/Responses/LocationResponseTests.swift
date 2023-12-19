import XCTest

@testable import SpaceLaunches

final class LocationResponseTests: XCTestCase {

    func test_LocationResponse_successfullyDecodedWhenValidJSONIsProvided() {
        // Given
        let validJSON = """
            {
                "id": 1,
                "name": "Kennedy Space Center"
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(LocationResponse.self, from: Data(validJSON)))
    }
}
