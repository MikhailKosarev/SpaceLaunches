/// The response data for the launch service provider information.
struct LaunchServiceProviderResponse: Codable {
    /// The unique identifier for the launch service provider.
    let id: Int
    /// The name of the launch service provider.
    let name: String
    /// The URL for the logo of the launch service provider, if available.
    let logoURL: String?

    /// Coding keys to map the structure to JSON keys during encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoURL = "logo_url"
    }
}
