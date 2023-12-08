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

    func test_getLongDateWithShortTime_ReturnsNilWhenGivenEmptyDate() {
        // Given
        let emptyDate = ""

        // When
        let formattedDate = formatter.getLongDateWithShortTime(from: emptyDate)

        // Then
        XCTAssertNil(formattedDate)
    }

    func test_getLongDateWithShortTime_ReturnsNilWhenGivenInvalidDateFormat() {
        // Given
        let invalidDateFormat = "2023-12-08 12:34:56"

        // When
        let formattedDate = formatter.getLongDateWithShortTime(from: invalidDateFormat)

        // Then
        XCTAssertNil(formattedDate)
    }

    func test_getLongDateWithShortTime_ReturnsFormattedDateWithDifferentTimeZone() {
        // Given
        let dateWithDifferentTimeZone = "1970-01-01T00:00:00-0300"
        let threeHoursInSeconds = 10800
        let expectedFormattedDate = Date(timeIntervalSince1970: TimeInterval(threeHoursInSeconds))
            .formatted(date: .long, time: .shortened)

        // When
        let actualFormattedDate = formatter.getLongDateWithShortTime(from: dateWithDifferentTimeZone)

        // Then
        XCTAssertEqual(actualFormattedDate, expectedFormattedDate)
    }
}
