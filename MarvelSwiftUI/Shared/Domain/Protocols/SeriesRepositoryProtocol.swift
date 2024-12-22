import Foundation

/// A protocol that defines the requirements for a repository handling series data.
protocol SeriesRepositoryProtocol {
    
    /// Retrieves a list of series from the repository.
    ///
    /// - Parameters:
    ///   - ts: A timestamp used for authentication.
    ///   - hash: The MD5 hash generated from the timestamp, private key, and public key.
    ///   - apikey: The public key provided by the Marvel API.
    ///   - characterID: The ID of the character to filter the series results.
    ///
    /// - Returns: An array of `MarvelSeries` objects.
    /// - Throws: An error if the network request fails or the data cannot be decoded.
    func getSeries(ts: String, hash: String, apikey: String, characterID: Int) async throws -> [MarvelSeries]
}
