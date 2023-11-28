/// The response data for the rocket configuration information.
struct RocketConfigurationResponse: Decodable {
    /// The unique identifier for the rocket configuration.
    let id: Int
    /// The name of the rocket configuration.
    let name: String
    /// The URL for the image of the rocket configuration, if available.
    let imageURL: String?

    /// Coding keys to map the structure to JSON keys during encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
    }
}
