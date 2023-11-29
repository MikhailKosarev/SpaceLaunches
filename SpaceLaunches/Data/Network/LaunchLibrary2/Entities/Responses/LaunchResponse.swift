/// The response data for a launch, designed for decoding JSON responses.
struct LaunchResponse: Decodable {
    /// The unique identifier for the launch.
    let id: String
    /// The name of the launch.
    let name: String
    /// The status of the launch, `nil` if unavailable.
    let status: LaunchStatusResponse?
    /// The scheduled launch date and time in ISO 8601 format, `nil` if unavailable.
    let net: String?
    /// Information about the launch service provider, `nil` if unavailable.
    let launchServiceProvider: LaunchServiceProviderResponse?
    /// Information about the rocket used in the launch, `nil` if unavailable.
    let rocket: RocketResponse?
    /// Information about the mission associated with the launch, `nil` if unavailable.
    let mission: MissionResponse?
    /// Information about the launch pad, `nil` if unavailable.
    let pad: PadResponse?
    /// The URL to an image related to the launch, `nil` if unavailable.
    let image: String?

    /// Coding keys to map the structure to JSON keys during encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case net
        case launchServiceProvider = "launch_service_provider"
        case rocket
        case mission
        case pad
        case image
    }
}
