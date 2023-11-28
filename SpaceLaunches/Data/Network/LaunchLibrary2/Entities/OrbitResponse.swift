/// The response data for the orbit information.
struct OrbitResponse: Decodable {
    /// The unique identifier for the orbit.
    let id: Int
    /// The name of the orbit.
    let name: String
    /// The abbreviated representation of the orbit.
    let abbrev: String

    /// Coding keys to map the structure to JSON keys during encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case abbrev
    }
}
