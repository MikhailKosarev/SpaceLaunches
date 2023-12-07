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

    func test_MissionResponse_failsDecodingWhenKeyIsMissing() {
        // Given
        let jsonWithoutIdKey = """
            {
                "name": "Sample Mission",
                "description": "Mission Description",
                "type": "Sample Type",
                "orbit": {"id": 1, "name": "Low Earth Orbit", "abbrev": "LEO"},
                "agencies": [{"id": 1, "name": "NASA", "logo_url": "https://example.com/nasa_logo"}]
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(MissionResponse.self, from: Data(jsonWithoutIdKey)))
    }

    func test_MissionResponse_failsDecodingWhenKeyIsNotValidType() {
        // Given
        let jsonWithInvalidId = """
            {
                "id": "not_an_integer",
                "name": "Sample Mission",
                "description": "Mission Description",
                "type": "Sample Type",
                "orbit": {"id": 1, "name": "Low Earth Orbit", "abbrev": "LEO"},
                "agencies": [{"id": 1, "name": "NASA", "logo_url": "https://example.com/nasa_logo"}]
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(MissionResponse.self, from: Data(jsonWithInvalidId)))
    }

    func test_MissionResponse_successfullyDecodedWithExtraKeys() {
        // Given
        let jsonWithExtraKeys = """
            {
                "id": 1,
                "name": "Sample Mission",
                "description": "Mission Description",
                "type": "Sample Type",
                "orbit": {"id": 1, "name": "Low Earth Orbit", "abbrev": "LEO"},
                "agencies": [{"id": 1, "name": "NASA", "logo_url": "https://example.com/nasa_logo"}],
                "extraKey": "extraValue"
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(MissionResponse.self, from: Data(jsonWithExtraKeys)))
    }
}
