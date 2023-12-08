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

}
