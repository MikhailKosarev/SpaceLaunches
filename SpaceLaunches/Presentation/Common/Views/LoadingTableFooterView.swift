import UIKit

/// A custom table footer view used for displaying loading indicators.
final class LoadingTableFooterView: UIView {

    // MARK: - Internal interface
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    /// Initializes and returns a newly allocated view object from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    /// Starts animating the activity indicator.
    func startAnimating() {
        activityIndicator.startAnimating()
    }

    /// Stops animating the activity indicator.
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }

    // MARK: - Private interface
    /// The activity indicator view.
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()

    private func setup() {
        addSubview(activityIndicator)
        activityIndicator.center = center
    }
}
