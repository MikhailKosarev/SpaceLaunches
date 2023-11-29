/// The response data for pad information, designed for decoding JSON responses.
struct PadResponse: Decodable {
    /// The unique identifier for the pad.
    let id: Int
    /// The latitude of the pad, `nil` if unavailable.
    let latitude: String?
    /// The longitude of the pad, `nil` if unavailable.
    let longitude: String?
    /// The location details associated with the pad, `nil` if unavailable.
    let location: LocationResponse?

    /// Coding keys to map the structure to JSON keys during encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id
        case latitude
        case longitude
        case location
    }
}
