import RxTest
import XCTest

/// A class for recording and asserting events in RxSwift tests.
class Recorder {

    /// Asserts that the specified recorder has emitted the expected number of events.
    ///
    /// - Parameters:
    ///   - times: The expected number of events.
    ///   - recorder: The key path to the recorder.
    ///   - timeout: The maximum time to wait for the events to be emitted. Default is 15 seconds.
    ///   - eventName: A custom name for the event (optional).
    ///   - file: The file name to include in the failure message.
    ///   Default is the file where the assertion was called.
    ///   - line: The line number to include in the failure message.
    ///   Default is the line number where the assertion was called.
    public func assertEventsEmitted<T>(times: Int,
                                       recorder: KeyPath<Recorder, TestableObserver<T>>,
                                       timeout: Int = 15,
                                       eventName: String? = nil,
                                       file: StaticString = #file,
                                       line: UInt = #line) {
        let name = eventName ?? String(describing: recorder)
        let eventsCount = self[keyPath: recorder].events.count
        XCTAssertEqual(eventsCount, times, file: file, line: line)
    }

    /// Asserts that the specified recorder has not emitted any events.
    ///
    /// - Parameters:
    ///   - recorder: The key path to the recorder.
    ///   - eventName: A custom name for the event (optional).
    ///   - file: The file name to include in the failure message.
    ///   Default is the file where the assertion was called.
    ///   - line: The line number to include in the failure message.
    ///   Default is the line number where the assertion was called.
    public func assertNoEventsEmitted<T>(recorder: KeyPath<Recorder, TestableObserver<T>>,
                                         eventName: String? = nil,
                                         file: StaticString = #file,
                                         line: UInt = #line) {
        let name = eventName ?? String(describing: recorder)
        let eventsCount = self[keyPath: recorder].events.count
        XCTAssertEqual(eventsCount, 0, file: file, line: line)
    }

    /// Asserts that the specified recorder's event at the given order is a completion event.
    ///
    /// - Parameters:
    ///   - order: The order of the event to check.
    ///   - recorder: The key path to the recorder.
    ///   - file: The file name to include in the failure message.
    ///   Default is the file where the assertion was called.
    ///   - line: The line number to include in the failure message.
    ///   Default is the line number where the assertion was called.
    public func assertEventCompleted<T: Equatable>(at order: Int,
                                                   for recorder: KeyPath<Recorder, TestableObserver<T>>,
                                                   file: StaticString = #file,
                                                   line: UInt = #line) {
        let eventValue = self[keyPath: recorder].events[order].value
        XCTAssertEqual(eventValue, .completed, file: file, line: line)
    }

    /// Asserts that the specified recorder's event at the given order has the expected element.
    ///
    /// - Parameters:
    ///   - element: The expected element.
    ///   - order: The order of the event to check.
    ///   - recorder: The key path to the recorder.
    ///   - file: The file name to include in the failure message.
    ///   Default is the file where the assertion was called.
    ///   - line: The line number to include in the failure message.
    ///   Default is the line number where the assertion was called.
    public func assertEventElement<T: Equatable>(_ element: T,
                                                 at order: Int,
                                                 for recorder: KeyPath<Recorder, TestableObserver<T>>,
                                                 file: StaticString = #file,
                                                 line: UInt = #line) {
        let eventElement = self[keyPath: recorder].events[order].value.element
        XCTAssertEqual(eventElement, element, file: file, line: line)
    }
}
