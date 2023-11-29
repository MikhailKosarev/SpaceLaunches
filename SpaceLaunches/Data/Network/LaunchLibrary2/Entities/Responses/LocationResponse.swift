/// The response data for location information, designed for decoding JSON responses.
struct LocationResponse: Decodable {
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
