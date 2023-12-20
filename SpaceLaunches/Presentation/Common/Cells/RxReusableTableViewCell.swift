import Reusable
import RxSwift
import UIKit

/// Custom table view cell with RxSwift integration and Reusable conformance.
class RxReusableTableViewCell: UITableViewCell {

    /// Dispose bag for managing RxSwift subscriptions.
    private (set) var bag = DisposeBag()

    /// Prepares the cell for reuse by resetting the dispose bag.
    override func prepareForReuse() {
        bag = DisposeBag()
        super.prepareForReuse()
    }
}

// MARK: - Reusable Conformance
extension RxReusableTableViewCell: Reusable {}
