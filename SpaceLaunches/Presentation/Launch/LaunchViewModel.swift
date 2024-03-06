/// View model for managing the launch detailed info.
struct LaunchViewModel {

    // MARK: - Private interface

    private let coordinator: LaunchCoordinator

    init(coordinator: LaunchCoordinator) {
        self.coordinator = coordinator
    }
}

// MARK: - LaunchViewModelType
extension LaunchViewModel: LaunchViewModelType {

    /// The input for the launch view model.
    struct Input: LaunchInput {
    }

    /// The output for the launch view model.
    struct Output: LaunchOutput {
    }

    /// Transforms the input into output for the launch.
    /// - Parameter input: The input for the 'LaunchViewModel'.
    /// - Returns: The output for the 'LaunchViewModel'.
    func transform(input: LaunchInput) -> LaunchOutput {
        Output()
    }
    
    /// Constructs the input for the 'LaunchViewModel'.
    /// - Returns: The input for the launch  view model.
    func input() -> LaunchInput {
        Input()
    }
}
