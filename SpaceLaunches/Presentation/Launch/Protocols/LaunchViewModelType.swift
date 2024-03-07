/// Protocol defining the requirements for a ViewModel associated with a Launch Screen.
protocol LaunchViewModelType {

    /// Transforms the input from the View into an output that can be consumed.
    ///
    /// This method encapsulates the core logic of how the ViewModel processes incoming data (`LaunchInput`)
    /// and produces an output (`LaunchOutput`) that the View can use to update its state.
    ///
    /// - Parameter input: The input from the View, typically user interactions or lifecycle events.
    /// - Returns: The output that the View uses to render its state.
    func transform(input: LaunchInput) -> LaunchOutput

    /// Provides the initial input for the ViewModel.
    ///
    /// This method is used to retrieve the initial set of data or configuration the ViewModel
    /// requires to start its transformation process. It's particularly useful for setting up
    /// the ViewModel with default states or pre-configured data.
    ///
    /// - Returns: The initial `LaunchInput` required by the ViewModel.
    func input() -> LaunchInput
}
