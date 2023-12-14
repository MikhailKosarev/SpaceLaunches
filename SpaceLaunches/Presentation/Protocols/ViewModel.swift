/// A protocol defining the ViewModel.
protocol ViewModel {

    /// Associated type for input to the ViewModel.
    associatedtype Input

    /// Associated type for output from the ViewModel.
    associatedtype Output

    /// Transforms the input into the output.
    /// - Parameter input: The input to the ViewModel.
    /// - Returns: The output from the ViewModel.
    func transform(input: Input) -> Output
}
