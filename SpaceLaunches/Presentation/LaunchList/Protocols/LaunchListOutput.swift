import RxCocoa
import RxSwift

/// Protocol defining the output for a launch list.
protocol LaunchListOutput {

    /// Driver emitting errors that occur during the launch list operation.
    var errors: Driver<Error> { get }
    /// Driver emitting a boolean indicating the loading state.
    var isLoading: Driver<Bool> { get }
    /// Driver emitting an array of launch list sections to be displayed.
    var cells: Driver<[LaunchListSection]> { get }
}
