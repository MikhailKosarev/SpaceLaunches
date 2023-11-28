/// Paginated response for the list of launches.
struct LaunchListResponse: Decodable {
    /// The total count of launches available.
    let count: Int
    /// The URL for the next page of launches, if available.
    let next: String?
    /// The URL for the previous page of launches, if available.
    let previous: String?
    /// Contains `LaunchResponse` objects representing launches in the current response.
    let results: [LaunchResponse]

    /// Coding keys to map the structure to JSON keys during encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
}
