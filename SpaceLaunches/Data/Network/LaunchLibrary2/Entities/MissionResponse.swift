/// The response data for mission information, designed for decoding JSON responses.
struct MissionResponse: Decodable {
    /// The unique identifier for the mission.
    let id: Int
    /// The name of the mission.
    let name: String
    /// The description of the mission.
    let description: String
    /// The type of the mission.
    let type: String
    /// The orbit details associated with the mission, `nil` if unavailable.
    let orbit: OrbitResponse?
    /// The agencies involved in the mission, `nil` if unavailable.
    let agencies: [AgencyResponse]?

    /// Coding keys to map the structure to JSON keys during encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case type
        case orbit
        case agencies
    }
}
