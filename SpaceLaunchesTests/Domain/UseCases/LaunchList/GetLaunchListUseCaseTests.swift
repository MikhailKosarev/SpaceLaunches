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

    // MARK: - Tests
    func test_produce_emitsExpectedValueOnServiceSuccessWithNoLaunches() throws {
        // Given
        let (received, expected) = createModels(numberOfLaunches: 0)
        let getLaunchListUseCaseStub = createSuccessEvent(response: received)
        let getLaunchListUseCase = createUseCase(with: getLaunchListUseCaseStub)
        let action = getLaunchListUseCase.produce(input: getNoMatterInput())
        let expectation = XCTestExpectation()

        // When
        action.elements
            .subscribe(onNext: { elements in
                // Then
                XCTAssertEqual(elements, expected)
                expectation.fulfill()
            })
            .disposed(by: bag)

        Driver.just(())
            .drive(action.inputs)
            .disposed(by: bag)

        wait(for: [expectation], timeout: fetchTimeout)
    }

    func test_produce_emitsExpectedValueOnServiceSuccessWithOneLaunch() throws {
        // Given
        let (received, expected) = createModels(numberOfLaunches: 1)
        let getLaunchListUseCaseStub = createSuccessEvent(response: received)
        let getLaunchListUseCase = createUseCase(with: getLaunchListUseCaseStub)
        let action = getLaunchListUseCase.produce(input: getNoMatterInput())
        let expectation = XCTestExpectation()

        // When
        action.elements
            .subscribe(onNext: { elements in
                // Then
                XCTAssertEqual(elements, expected)
                expectation.fulfill()
            })
            .disposed(by: bag)

        Driver.just(())
            .drive(action.inputs)
            .disposed(by: bag)

        wait(for: [expectation], timeout: fetchTimeout)
    }

    func test_produce_emitsExpectedValueOnServiceSuccessWithALotOfLaunches() throws {
        // Given
        let (received, expected) = createModels(numberOfLaunches: 50)
        let getLaunchListUseCaseStub = createSuccessEvent(response: received)
        let getLaunchListUseCase = createUseCase(with: getLaunchListUseCaseStub)
        let action = getLaunchListUseCase.produce(input: getNoMatterInput())
        let expectation = XCTestExpectation()

        // When
        action.elements
            .subscribe(onNext: { elements in
                // Then
                XCTAssertEqual(elements, expected)
                expectation.fulfill()
            })
            .disposed(by: bag)

        Driver.just(())
            .drive(action.inputs)
            .disposed(by: bag)

        wait(for: [expectation], timeout: 10)
    }
    // MARK: - Helper properties and methods
    private var scheduler: TestScheduler!
    private var bag: DisposeBag!
    private let fetchTimeout: TimeInterval = 10

    private func getNoMatterInput() -> GetLaunchListUseCase.Input {
        GetLaunchListUseCase.Input(type: .just(LaunchListDisplayType.upcoming),
                                   limit: .just(10),
                                   offset: .just(0))
    }

    private func createUseCase(with stub: Single<LaunchListResponse>) -> GetLaunchListUseCase {
        let mockLaunchService = MockLaunchService()
        mockLaunchService.getLaunchListStub = stub
        let getLaunchListUseCase = GetLaunchListUseCase(service: mockLaunchService)
        return getLaunchListUseCase
    }

    private func createFailureEvent(with error: Error) -> Single<LaunchListResponse> {
        Single.error(error)
    }

    private func createSuccessEvent(response: LaunchListResponse) -> Single<LaunchListResponse> {
        Single.just(response)
    }

    private func createModels(numberOfLaunches: Int) -> (received: LaunchListResponse, expected: [LaunchListItem]) {
        let launchResponse = LaunchResponse(
            id: "1",
            name: "Launch 1",
            status: nil,
            net: "2023-01-01",
            launchServiceProvider: LaunchServiceProviderResponse(id: 1, name: "Provider 1", logoURL: nil),
            rocket: nil,
            mission: nil,
            pad: PadResponse(
                id: 1,
                latitude: nil,
                longitude: nil,
                location: LocationResponse(id: 0, name: "Pad 1")
            ),
            image: "https://example.com/image.jpg"
        )

        let launchResponses = Array(repeating: launchResponse, count: numberOfLaunches)

        let launchListResponse = LaunchListResponse(count: 10,
                                                    next: nil,
                                                    previous: nil,
                                                    results: launchResponses)

        let launchListItem = LaunchListItem(
            id: "1",
            imageURL: URL(string: "https://example.com/image.jpg"),
            name: "Launch 1",
            net: "Launch date is unknown",
            launchServiceProvider: "Provider 1",
            location: "Pad 1"
        )

        let launchListItems = Array(repeating: launchListItem, count: numberOfLaunches)

        return (launchListResponse, launchListItems)
    }
}
