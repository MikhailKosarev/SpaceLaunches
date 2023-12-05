import XCTest

@testable import SpaceLaunches

final class RocketConfigurationResponseTests: XCTestCase {

    func test_RocketConfigurationResponse_successfullyDecodedWhenValidJSONIsProvided() {
        // Given
        let validJSON = """
            {
                "id": 1,
                "name": "Falcon 9",
                "image_url": "https://example.com/image"
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(RocketConfigurationResponse.self,
                                                  from: Data(validJSON)))
    }

}
