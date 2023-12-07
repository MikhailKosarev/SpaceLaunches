import XCTest

@testable import SpaceLaunches

final class MissionResponseTests: XCTestCase {

    func test_MissionResponse_successfullyDecodedWhenValidJSONIsProvided() {
        // Given
        let validJSON = """
            {
                "id": 1,
                "name": "Sample Mission",
                "description": "Mission Description",
                "type": "Sample Type",
                "orbit": {"id": 1, "name": "Low Earth Orbit", "abbrev": "LEO"},
                "agencies": [{"id": 1, "name": "NASA", "logo_url": "https://example.com/nasa_logo"}]
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(MissionResponse.self, from: Data(validJSON)))
    }

    func test_MissionResponse_failsDecodingWhenAllRequiredValuesNull() {
        // Given
        let allNullJSON = """
        {
            "id": null,
            "name": null,
            "description": null,
            "type": null,
            "orbit": null,
            "agencies": null
        }
        """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(MissionResponse.self, from: Data(allNullJSON)))
    }
}
