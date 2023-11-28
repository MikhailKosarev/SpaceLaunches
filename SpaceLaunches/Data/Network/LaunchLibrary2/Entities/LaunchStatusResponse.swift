/// The response data for the launch status information, designed for decoding JSON responses.
struct LaunchStatusResponse: Decodable {
    /// The unique identifier for the launch status.
    let id: Int
    /// The name of the launch status.
    let name: String
    /// The abbreviated representation of the launch status.
    let abbrev: String
    /// The description of the launch status.
    let description: String

    /// Coding keys to map the structure to JSON keys during encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case abbrev
        case description
    }
}
