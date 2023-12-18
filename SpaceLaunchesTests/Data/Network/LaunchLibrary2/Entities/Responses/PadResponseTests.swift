import XCTest

@testable import SpaceLaunches

final class PadResponseTests: XCTestCase {

    func test_PadResponse_successfullyDecodedWhenValidJSONIsProvided() {
        // Given
        let validJSON = """
            {
                "id": 1,
                "latitude": "28.5623",
                "longitude": "-80.5774",
                "location": {
                    "id": 101,
                    "name": "Kennedy Space Center"
                }
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(PadResponse.self, from: Data(validJSON)))
    }

    func test_PadResponse_failsDecodingWhenAllRequiredValuesNull() {
        // Given
        let allNullJSON = """
        {
            "id": null,
            "latitude": null,
            "longitude": null,
            "location": null
        }
        """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(PadResponse.self, from: Data(allNullJSON)))
    }
}
