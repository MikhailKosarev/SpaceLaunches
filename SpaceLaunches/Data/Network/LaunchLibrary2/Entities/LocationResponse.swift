/// The response data for the location information.
struct LocationResponse: Codable {
    /// The unique identifier for the location.
    let id: Int
    /// The name of the location.
    let name: String

    /// Coding keys to map the structure to JSON keys during encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
