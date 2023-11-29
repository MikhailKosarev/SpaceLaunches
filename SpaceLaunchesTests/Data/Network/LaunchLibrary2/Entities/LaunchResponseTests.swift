import XCTest

@testable import SpaceLaunches

final class LaunchResponseTests: XCTestCase {

    func test_LaunchResponse_successfullyDecodedWhenValidJSONIsProvided() {
        // Given
        // swiftlint:disable line_length
        let validJSON = """
                {
                    "id": "1",
                    "name": "Launch 1",
                    "status": {"id": 1, "name": "Status", "abbrev": "S", "description": "Launch Status"},
                    "net": "2023-11-29T12:00:00Z",
                    "launch_service_provider": {"id": 1, "name": "Provider", "logoURL": "https://example.com/logo"},
                    "rocket": {"id": 1, "configuration": {"id": 1, "name": "Rocket", "imageURL": "https://example.com/image"}},
                    "mission": {"id": 1, "name": "Mission", "description": "Mission Description", "type": "Type", "orbit": {"id": 1, "name": "Orbit", "abbrev": "O"}},
                    "pad": {"id": 1, "latitude": "28.5623", "longitude": "-80.5774", "location": {"id": 1, "name": "Cape Canaveral"}},
                    "image": "https://example.com/image"
                }
                """.utf8
        // swiftlint:enable line_length
        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(LaunchResponse.self, from: Data(validJSON)))
    }
}
