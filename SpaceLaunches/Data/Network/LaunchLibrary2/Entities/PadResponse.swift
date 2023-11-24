/// The response data for the pad information.
struct PadResponse: Codable {
    /// The unique identifier for the pad.
    let id: Int
    /// The latitude of the pad, if available.
    let latitude: String?
    /// The longitude of the pad, if available.
    let longitude: String?
    /// The location details associated with the pad, if available.
    let location: LocationResponse?

    /// Coding keys to map the structure to JSON keys during encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id
        case latitude
        case longitude
        case location
    }
}
