import RxCocoa
import RxSwift

/// Reactive extensions for `UIViewController` lifecycle events.
extension Reactive where Base: UIViewController {
    /// Reactive event triggered on `viewDidLoad`.
    var viewDidLoad: ControlEvent<Void> {
        ControlEvent(events: emptyMethodInvoked(#selector(Base.viewDidLoad)))
    }
    /// Reactive event triggered  on `viewWillAppear`.
    var viewWillAppear: ControlEvent<Void> {
        ControlEvent(events: emptyMethodInvoked(#selector(Base.viewWillAppear(_:))))
    }
    /// Reactive event triggered  on `viewDidAppear`.
    var viewDidAppear: ControlEvent<Void> {
        ControlEvent(events: emptyMethodInvoked(#selector(Base.viewDidAppear(_:))))
    }
    /// Reactive event triggered  on `viewWillDisappear`.
    var viewWillDisappear: ControlEvent<Void> {
        ControlEvent(events: emptyMethodInvoked(#selector(Base.viewWillDisappear(_:))))
    }
    /// Reactive event triggered  on `viewDidDisappear`.
    var viewDidDisappear: ControlEvent<Void> {
        ControlEvent(events: emptyMethodInvoked(#selector(Base.viewDidDisappear(_:))))
    }
    /// Reactive event triggered  on `touchesBegan`.
    var touchesBegan: ControlEvent<Void> {
        ControlEvent(events: emptyMethodInvoked(#selector(Base.touchesBegan(_:with:))))
    }

    /// Maps method invocations to an observable emitting void events.
    /// - Parameter selector: The selector of the method to be observed.
    /// - Returns: Observable emitting void events.
    private func emptyMethodInvoked(_ selector: Selector) -> Observable<Void> {
        methodInvoked(selector).map { _ in }
    }
}
