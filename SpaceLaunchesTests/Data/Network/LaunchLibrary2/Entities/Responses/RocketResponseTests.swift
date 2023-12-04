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
}
