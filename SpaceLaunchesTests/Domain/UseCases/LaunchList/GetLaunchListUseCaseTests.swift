import RxCocoa
import RxSwift
import RxTest
import XCTest

@testable import SpaceLaunches

final class GetLaunchListUseCaseTests: XCTestCase {

    // MARK: - Setup and Teardown
    override func setUp() {
        super.setUp()
        bag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        super.tearDown()
        bag = nil
        scheduler = nil
    }


    // MARK: - Helper properties and methods
    private var scheduler: TestScheduler!
    private var bag: DisposeBag!
}
