import RxCocoa
import RxSwift
import UIKit

/// Extension providing reactive capabilities for `UIRefreshControl`.
extension Reactive where Base: UIRefreshControl {

    /// A driver emitting a void event when the user pulls to refresh.
    var didPullToRefresh: Driver<Void> {
        base.rx.controlEvent(.valueChanged)
            .map { base.isRefreshing }
            .filter { $0 }.map { _ in }
            .asDriver(onErrorDriveWith: .never())
    }
}
