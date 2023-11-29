/// Parameters required for making a request to retrieve a list of launches.
struct GetLaunchListRequestParameters {
    /// The maximum number of items to include in the API response.
    let limit: Int
    /// The offset indicating the starting position of the list for pagination.
    let offset: Int
    /// The mode for obtaining detailed launch list information (default is "Detailed").
    let mode: LaunchListMode = .detailed
}
