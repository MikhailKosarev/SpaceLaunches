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

    func test_OrbitResponse_failsDecodingWhenAllRequiredValuesNull() {
        // Given
        let allNullJSON = """
        {
            "id": null,
            "name": null,
            "abbrev": null
        }
        """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(OrbitResponse.self, from: Data(allNullJSON)))
    }
}
