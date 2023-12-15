import RxCocoa
import Action

extension Action {

    /// Reactive driver emitting errors from the action.
    var errorDriver: Driver<Error> {
        underlyingError.asDriver(onErrorDriveWith: .never())
    }

    /// Reactive driver indicating the fetching state of the action.
    var fetchingDriver: Driver<Bool> {
        executing.asDriver(onErrorJustReturn: false)
    }

    /// Reactive driver emitting elements from the action.
    var elementsDriver: Driver<Element> {
        elements.asDriver(onErrorDriveWith: .never())
    }
}
