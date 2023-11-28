/// The response data for launch service provider information, designed for decoding JSON responses.
struct LaunchServiceProviderResponse: Decodable {
    /// The unique identifier for the launch service provider.
    let id: Int
    /// The name of the launch service provider.
    let name: String
    /// The URL for the logo of the launch service provider, `nil` if unavailable.
    let logoURL: String?

    /// Coding keys to map the structure to JSON keys during encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoURL = "logo_url"
    }
}
