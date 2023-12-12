import XCTest

@testable import SpaceLaunches

final class AgencyResponseTests: XCTestCase {

    func test_AgencyResponse_successfullyDecodedWhenValidJSONIsProvided() {
        // Given
        let validJSON = """
            {
                "id": 1,
                "name": "NASA",
                "logo_url": "https://example.com/nasa_logo.png"
            }
            """.utf8

        // When & Then
        XCTAssertNoThrow(try JSONDecoder().decode(AgencyResponse.self, from: Data(validJSON)))
    }

    func test_AgencyResponse_failsDecodingWhenAllRequiredValuesNull() {
        // Given
        let allNullJSON = """
        {
            "id": null,
            "name": null,
            "logo_url": null
        }
        """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(AgencyResponse.self, from: Data(allNullJSON)))
    }

    func test_AgencyResponse_failsDecodingWhenKeyIsMissing() {
        // Given
        let jsonWithoutIdKey = """
            {
                "name": "NASA",
                "logo_url": "https://example.com/nasa_logo.png"
            }
            """.utf8

        // When & Then
        XCTAssertThrowsError(try JSONDecoder().decode(AgencyResponse.self, from: Data(jsonWithoutIdKey)))
    }
}
