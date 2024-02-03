import RxCocoa
import RxSwift

/// Protocol defining the input for a launch list.
protocol LaunchListInput {

    /// Driver emitting a void event when the view is loaded.
    var viewDidLoad: Driver<Void> { get }
    /// Driver emitting the selected launch item.
    var selectedLaunch: Driver<LaunchListItem> { get }
    /// Driver emitting an array of row indices to prefetch.
    var rowsToPrefetch: Driver<[Int]> { get }
    /// Driver emitting the selected type of launches to display.
    var selectedLaunchesType: Driver<LaunchListDisplayType> { get }
}
