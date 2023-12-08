import Foundation

/// A utility for formatting date strings using `ISO8601` date format.
struct DateTimeFormatter {

    // MARK: - Internal interface
    /// Formats a date string in `ISO8601` format into a string with long date and shortened time representation.
    ///
    /// For example, for the date string "2023-12-08T12:34:56Z",
    /// the formatted result will be "December 8, 2023 at 12:34 PM".
    ///
    /// - Parameter date: The date string in `ISO8601` format to be formatted.
    /// - Returns: A formatted string representing the long date with shortened time,
    ///            or `nil` if formatting fails.
    ///
    /// - Note: The formatted date is based on the current time zone of the device.
    func getLongDateWithShortTime(from date: String) -> String? {
        let date = dateFormatter.date(from: date)
        return date?.formatted(date: .long, time: .shortened)
    }

    // MARK: - Private interface
    private let dateFormatter = ISO8601DateFormatter()
}
