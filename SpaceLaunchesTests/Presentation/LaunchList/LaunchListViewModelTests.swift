import RxCocoa
import RxSwift
import RxTest
import XCTest

@testable import SpaceLaunches

// swiftlint:disable type_body_length
final class LaunchListViewModelTests: XCTestCase {

    // MARK: - Tests for Output.errors
    func test_output_errors_ShouldNotEmitWhenInputIsNever() {
        // Given
        let input = neverInput()
        var errorEmitted = false

        // When
        let output = viewModel.transform(input: input)
        output.errors
            .drive(onNext: { _ in errorEmitted = true })
            .disposed(by: bag)

        // Then
        XCTAssertFalse(errorEmitted)
    }

    // MARK: - Tests for Output.isLoading
    func test_output_isLoading_ShouldEmitFalseWhenInputIsNever() {
        // Given
        let input = neverInput()
        let expectation = XCTestExpectation()
        var emittedEvents: [Bool] = []
        let expectedEvents = [false, false]

        // When
        let output = viewModel.transform(input: input)
        output.isLoading
            .drive(onNext: { isLoading in
                emittedEvents.append(isLoading)
                expectation.fulfill()
            })
            .disposed(by: bag)

        // Then
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertEqual(emittedEvents, expectedEvents)
    }

    func test_output_isLoading_ShouldEmitTrueWhenViewDidLoadEmits() {
        // Given
        let viewDidLoadRelay = PublishRelay<Void>()
        let input = viewModel.input(viewdDidLoad: viewDidLoadRelay.asDriver(onErrorDriveWith: .never()),
                                    selectedLaunch: .never(),
                                    rowsToPrefetch: .never(),
                                    didPullToRefresh: .never(),
                                    selectedLaunchesType: .never())

        let expectation = XCTestExpectation()
        var emittedEvents: [Bool] = []
        let expectedEvents = [false, false, true, false]

        // When
        let output = viewModel.transform(input: input)
        output.isLoading
            .drive(onNext: { isLoading in
                emittedEvents.append(isLoading)
                expectation.fulfill()
            })
            .disposed(by: bag)

        viewDidLoadRelay.accept(())

        // Then
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertEqual(emittedEvents, expectedEvents)
    }

    func test_output_isLoading_ShouldEmitFalseWhenSelectedLaunchEmits() {
        // Given
        let selectedLaunchRelay = PublishRelay<LaunchListItem>()
        let input = viewModel.input(viewdDidLoad: .never(),
                                    selectedLaunch: selectedLaunchRelay.asDriver(onErrorDriveWith: .never()),
                                    rowsToPrefetch: .never(),
                                    didPullToRefresh: .never(),
                                    selectedLaunchesType: .never())

        let expectation = XCTestExpectation()
        var emittedEvents: [Bool] = []

        // When
        let output = viewModel.transform(input: input)
        selectedLaunchRelay.accept(LaunchListItem.stub)

        output.isLoading
            .drive(onNext: { isLoading in
                emittedEvents.append(isLoading)
                expectation.fulfill()
            })
            .disposed(by: bag)

        // Then
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertEqual(emittedEvents, [false, false])
    }

    func test_output_isLoading_ShouldEmitFalseWhenRowsToPrefetchEmitsValueNotToPrefetch() {
        // Given
        let rowsToPrefetchRelay = PublishRelay<[Int]>()
        let input = viewModel.input(viewdDidLoad: .never(),
                                    selectedLaunch: .never(),
                                    rowsToPrefetch: rowsToPrefetchRelay.asDriver(onErrorDriveWith: .never()),
                                    didPullToRefresh: .never(),
                                    selectedLaunchesType: .never())

        let expectation = XCTestExpectation()
        var emittedEvents: [Bool] = []
        let expectedEvents = [false, false]

        // When
        let output = viewModel.transform(input: input)
        rowsToPrefetchRelay.accept([0])

        output.isLoading
            .drive(onNext: { isLoading in
                emittedEvents.append(isLoading)
                expectation.fulfill()
            })
            .disposed(by: bag)

        // Then
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertEqual(emittedEvents, expectedEvents)
    }

    func test_output_isLoading_ShouldEmitFalseWhenSelectedLaunchesTypeEmitsFirstValue() {
        // Given
        let selectedLaunchTypeRelay = PublishRelay<LaunchListDisplayType>()
        let input = viewModel.input(viewdDidLoad: .never(),
                                    selectedLaunch: .never(),
                                    rowsToPrefetch: .never(),
                                    didPullToRefresh: .never(),
                                    selectedLaunchesType: selectedLaunchTypeRelay.asDriver(onErrorDriveWith: .never()))

        let expectation = XCTestExpectation()
        var emittedEvents: [Bool] = []
        let expectedEvents = [false, false]

        // When
        let output = viewModel.transform(input: input)
        selectedLaunchTypeRelay.accept(LaunchListDisplayType.all)

        output.isLoading
            .drive(onNext: { isLoading in
                emittedEvents.append(isLoading)
                expectation.fulfill()
            })
            .disposed(by: bag)

        // Then
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertEqual(emittedEvents, expectedEvents)
    }

    func test_output_isLoading_ShouldEmitTrueWhenSelectedLaunchesTypeEmitsSecondAndFollowingValues() {
        // Given
        let selectedLaunchTypeRelay = PublishRelay<LaunchListDisplayType>()
        let input = viewModel.input(viewdDidLoad: .never(),
                                    selectedLaunch: .never(),
                                    rowsToPrefetch: .never(),
                                    didPullToRefresh: .never(),
                                    selectedLaunchesType: selectedLaunchTypeRelay.asDriver(onErrorDriveWith: .never()))

        let expectation = XCTestExpectation()
        var emittedEvents: [Bool] = []
        let expectedEvents = [false, false, true, false]

        // When
        let output = viewModel.transform(input: input)
        output.isLoading
            .drive(onNext: { isLoading in
                emittedEvents.append(isLoading)
                expectation.fulfill()
            })
            .disposed(by: bag)

        selectedLaunchTypeRelay.accept(LaunchListDisplayType.all)
        selectedLaunchTypeRelay.accept(LaunchListDisplayType.all)

        // Then
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertEqual(emittedEvents, expectedEvents)
    }

    // MARK: - Tests for Output.cells
    func test_output_cells_ShouldEmitArrayWithEmptyLaunchListSectionWhenInputIsNever() {
        // Given
        let input = neverInput()
        let expectation = XCTestExpectation()
        var emittedEvents: [LaunchListSection] = []
        let expectedEvents = [LaunchListSection(header: "Launches", items: [])]

        // When
        let output = viewModel.transform(input: input)
        output.cells
            .drive(onNext: { cells in
                emittedEvents.append(contentsOf: cells)
                expectation.fulfill()
            })
            .disposed(by: bag)

        // Then
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertEqual(emittedEvents, expectedEvents)
    }

    func test_output_cells_ShouldEmitArrayWithEmptyLaunchListSectionWhenViewDidLoadEmits() {
        // Given
        let viewDidLoadRelay = PublishRelay<Void>()
        let input = viewModel.input(viewdDidLoad: viewDidLoadRelay.asDriver(onErrorDriveWith: .never()),
                                    selectedLaunch: .never(),
                                    rowsToPrefetch: .never(),
                                    didPullToRefresh: .never(),
                                    selectedLaunchesType: .never())

        let expectation = XCTestExpectation()
        var emittedEvents: [LaunchListSection] = []
        let expectedEvents = [LaunchListSection(header: "Launches", items: [])]

        // When
        let output = viewModel.transform(input: input)
        output.cells
            .drive(onNext: { cells in
                emittedEvents.append(contentsOf: cells)
                expectation.fulfill()
            })
            .disposed(by: bag)

        viewDidLoadRelay.accept(())

        // Then
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertEqual(emittedEvents, expectedEvents)
    }

    func test_output_cells_ShouldEmitArrayWithEmptyLaunchListSectionWhenSelectedLaunchEmits() {
        // Given
        let selectedLaunchRelay = PublishRelay<LaunchListItem>()
        let input = viewModel.input(viewdDidLoad: .never(),
                                    selectedLaunch: selectedLaunchRelay.asDriver(onErrorDriveWith: .never()),
                                    rowsToPrefetch: .never(),
                                    didPullToRefresh: .never(),
                                    selectedLaunchesType: .never())

        let expectation = XCTestExpectation()
        var emittedEvents: [LaunchListSection] = []
        let expectedEvents = [LaunchListSection(header: "Launches", items: [])]

        // When
        let output = viewModel.transform(input: input)
        output.cells
            .drive(onNext: { cells in
                emittedEvents.append(contentsOf: cells)
                expectation.fulfill()
            })
            .disposed(by: bag)

        selectedLaunchRelay.accept(LaunchListItem.stub)

        // Then
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertEqual(emittedEvents, expectedEvents)
    }

    func test_output_cells_ShouldEmitArrayWithEmptyLaunchListSectionWhenRowsToPrefetchEmitsValueNotToPrefetch() {
        // Given
        let rowsToPrefetchRelay = PublishRelay<[Int]>()
        let input = viewModel.input(viewdDidLoad: .never(),
                                    selectedLaunch: .never(),
                                    rowsToPrefetch: rowsToPrefetchRelay.asDriver(onErrorDriveWith: .never()),
                                    didPullToRefresh: .never(),
                                    selectedLaunchesType: .never())

        let expectation = XCTestExpectation()
        var emittedEvents: [LaunchListSection] = []
        let expectedEvents = [LaunchListSection(header: "Launches", items: [])]

        // When
        let output = viewModel.transform(input: input)
        output.cells
            .drive(onNext: { cells in
                emittedEvents.append(contentsOf: cells)
                expectation.fulfill()
            })
            .disposed(by: bag)

        rowsToPrefetchRelay.accept([0])

        // Then
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertEqual(emittedEvents, expectedEvents)
    }

    func test_output_cells_ShouldEmitNewLaunchListSectionTrueWhenRowsToPrefetchEmitsValueNotToPrefetch() {
        // Given
        let selectedLaunchesTypeRelay = PublishRelay<LaunchListDisplayType>()
        let input = viewModel.input(viewdDidLoad: .never(),
                                    selectedLaunch: .never(),
                                    rowsToPrefetch: .never(),
                                    didPullToRefresh: .never(),
                                    selectedLaunchesType: selectedLaunchesTypeRelay
            .asDriver(onErrorDriveWith: .never()))

        let expectation = XCTestExpectation()
        var emittedEvents: [LaunchListSection] = []
        let expectedEvents = Array(repeating: LaunchListSection(header: "Launches", items: []), count: 1)

        // When
        let output = viewModel.transform(input: input)
        output.cells
            .drive(onNext: { cells in
                emittedEvents.append(contentsOf: cells)
                expectation.fulfill()
            })
            .disposed(by: bag)

        selectedLaunchesTypeRelay.accept(LaunchListDisplayType.all)

        // Then
        wait(for: [expectation], timeout: defaultTimeout)
        XCTAssertEqual(emittedEvents, expectedEvents)
    }

    // MARK: - Helper Methods
    private var viewModel: LaunchListViewModel!
    private var bag: DisposeBag!
    private let defaultTimeout = 2.0

    override func setUp() {
        super.setUp()
        bag = DisposeBag()
        viewModel = getViewModel()
    }

    override func tearDown() {
        bag = nil
        viewModel = nil
        super.tearDown()
    }

    private func getLaunchListStub() -> Single<LaunchListResponse> {
        Single.just(LaunchListResponse.stub(numberOfLaunches: 10))
    }

    private func getViewModel() -> LaunchListViewModel {
        let mockLaunchService = MockLaunchService()
        mockLaunchService.getLaunchListStub = getLaunchListStub()
        return LaunchListViewModel(coordinator: LaunchListCoordinator(navigationController: nil),
                                   service: mockLaunchService)
    }

    private func neverInput() -> LaunchListInput {
        viewModel.input(viewdDidLoad: .never(),
                        selectedLaunch: .never(),
                        rowsToPrefetch: .never(),
                        didPullToRefresh: .never(),
                        selectedLaunchesType: .never())
    }
}
// swiftlint:enable type_body_length
