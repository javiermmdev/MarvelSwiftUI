import Foundation

/// Represents the server-side endpoints utilized by the application.
/// Each case corresponds to a specific API endpoint.
enum Endpoints: String {
    /// Endpoint for retrieving a list of heroes and Shows.
    case listHeros = "/v1/public/characters"
    case listSeries = "/v1/public/series"
}
