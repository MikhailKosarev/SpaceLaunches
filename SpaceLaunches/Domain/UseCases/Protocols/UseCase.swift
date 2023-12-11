/// A protocol defining the structure of a use case in an application.
///
/// Use cases encapsulate the business logic of an application and provide a clear
/// separation between different layers, such as UI and data. They typically take
/// input parameters and produce output results.
///
/// - Note: Implementations of this protocol should provide concrete types for the
/// associated `Input` and `Output` types.
protocol UseCase {

    /// The type representing the input parameters for the use case.
    associatedtype Input
    /// The type representing the output result of the use case.
    associatedtype Output

    /// Executes the use case logic based on the provided input parameters and returns the result.
    ///
    /// - Parameter input: The input parameters for the use case.
    /// - Returns: The output result of the use case.
    func produce(input: Input) -> Output
}
