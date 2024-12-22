
import Foundation

/// Fetches series from the repository.
///
/// - Parameters:
///   - ts: Timestamp for authentication.
///   - hash: MD5 hash computed from the timestamp, private key, and public key.
///   - apikey: Public key provided by Marvel.
///   - characterID: The ID of the character to filter the series results.
/// - Returns: A list of series retrieved from the repository.
/// - Throws: An error if the network call fails.

/// Protocol defining the use case for fetching series.
protocol SeriesUseCaseProtocol {
    func getSeries(ts: String, hash: String, apikey: String, characterID: Int) async throws -> [MarvelSeries]
}

/// Implementation of the Series use case.
final class SeriesUseCase: SeriesUseCaseProtocol {
    
    private let repo: NetworkSeriesProtocol
    
    /// Initializes the use case with a repository.
    ///
    /// - Parameter repo: The repository implementing `NetworkSeriesProtocol`.
    ///   Defaults to the `DefaultSeriesRepository` implementation.
    init(repo: NetworkSeriesProtocol = DefaultSeriesRepository()) {
        self.repo = repo
    }
    
    func getSeries(ts: String, hash: String, apikey: String, characterID: Int) async throws -> [MarvelSeries] {
        return try await repo.getSeries(ts: ts, hash: hash, apikey: apikey, characterID: characterID)
    }
}
