/// The response data for agency information, designed for decoding JSON responses.
struct AgencyResponse: Decodable {
    /// The unique identifier for the agency.
    let id: Int
    /// The name of the agency.
    let name: String
    /// The URL for the logo of the agency, `nil` if unavailable.
    let logoURL: String?

    /// Coding keys to map the structure to JSON keys during encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoURL = "logo_url"
    }
}
