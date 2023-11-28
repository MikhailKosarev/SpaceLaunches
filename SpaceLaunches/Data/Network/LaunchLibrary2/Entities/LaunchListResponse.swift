/// A paginated response containing a list of launches, designed for decoding JSON responses.
struct LaunchListResponse: Decodable {
    /// The total count of launches available in the entire dataset.
    let count: Int
    /// The URL for the next page of launches, if available. `nil` if there is no next page.
    let next: String?
    /// The URL for the previous page of launches, if available. `nil` if there is no previous page.
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
