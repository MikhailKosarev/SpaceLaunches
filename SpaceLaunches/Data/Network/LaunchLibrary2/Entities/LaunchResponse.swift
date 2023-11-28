/// The response data for the launch.
struct LaunchResponse: Decodable {
    /// The unique identifier for the launch.
    let id: String
    /// The name of the launch.
    let name: String
    /// The status of the launch, if available.
    let status: LaunchStatusResponse?
    /// The scheduled launch date and time in ISO 8601 format.
    let net: String?
    /// Information about the launch service provider, if available.
    let launchServiceProvider: LaunchServiceProviderResponse?
    /// Information about the rocket used in the launch, if available.
    let rocket: RocketResponse?
    /// Information about the mission associated with the launch, if available.
    let mission: MissionResponse?
    /// Information about the launch pad, if available.
    let pad: PadResponse?
    /// The URL to an image related to the launch, if available.
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
