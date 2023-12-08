import XCTest

@testable import SpaceLaunches

final class DateTimeFormatterTests: XCTestCase {

    private var formatter: DateTimeFormatter!

    // MARK: - Setup and Teardown
    override func setUp() {
        super.setUp()
        formatter = DateTimeFormatter()
    }

    override func tearDown() {
        formatter = nil
        super.tearDown()
    }

    // MARK: - Test cases
    func test_getLongDateWithShortTime_ReturnsFormattedDateWhenGivenValidDate() {
        // Given
        let validDate = "1970-01-01T00:00:00Z"
        let expectedFormattedDate = Date(timeIntervalSince1970: .zero)
            .formatted(date: .long, time: .shortened)

        // When
        let actualFormattedDate = formatter.getLongDateWithShortTime(from: validDate)

        // Then
        XCTAssertEqual(actualFormattedDate, expectedFormattedDate)
    }
}
