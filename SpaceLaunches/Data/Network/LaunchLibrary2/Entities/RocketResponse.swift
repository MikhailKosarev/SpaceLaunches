/// The response data for the rocket information.
struct RocketResponse: Codable {
    /// The unique identifier for the rocket.
    let id: Int
    /// The rocket's configuration details.
    let configuration: RocketConfigurationResponse

    /// Coding keys to map the structure to JSON keys during encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id
        case configuration
    }
}
