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
}
