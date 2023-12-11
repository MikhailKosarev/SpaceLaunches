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
}
