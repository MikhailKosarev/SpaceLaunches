import RxCocoa
import RxSwift

/// Protocol defining the interface for a launch list view model.
protocol LaunchListViewModelType {

    /// Transforms the input into the output for the launch list.
    /// - Parameter input: The input containing various drivers for different events.
    /// - Returns: The output with drivers for errors, loading state, and cells.
    func transform(input: LaunchListInput) -> LaunchListOutput

    /// Creates and returns the input for the launch list view model.
    /// - Parameters:
    ///   - viewdDidLoad: Driver emitting a void event when the view is loaded.
    ///   - selectedLaunch: Driver emitting the selected launch item.
    ///   - rowsToPrefetch: Driver emitting an array of row indices to prefetch.
    ///   - selectedLaunchesType: Driver emitting the selected type of launches to display.
    /// - Returns: The `LaunchListInput` containing drivers for different events.
    func input(viewdDidLoad: Driver<Void>,
               selectedLaunch: Driver<LaunchListItem>,
               rowsToPrefetch: Driver<[Int]>,
               selectedLaunchesType: Driver<LaunchListDisplayType>) -> LaunchListInput
}
