import Foundation

/// Implementation of `NetworkSeriesProtocol` to fetch series from the Marvel API.
final class DefaultSeriesRepository: NetworkSeriesProtocol {
    
    private var network: NetworkSeriesProtocol
    
    /// Initializes the repository with a network service.
    init(network: NetworkSeriesProtocol = NetworkSeries()) {
        self.network = network
    }
    
    /// Fetches the series using the provided network service.
    func getSeries(ts: String, hash: String, apikey: String, characterID: Int) async throws -> [MarvelSeries] {
        return try await network.getSeries(ts: ts, hash: hash, apikey: apikey, characterID: characterID)
    }
}

/// Mock implementation of `NetworkSeriesProtocol` for testing purposes.
final class DefaultSeriesRepositoryMock: NetworkSeriesProtocol {
    
    private var network: NetworkSeriesProtocol
    
    /// Initializes the mock repository with a mock network service.
    init(network: NetworkSeriesProtocol = NetworkSeriesMock()) {
        self.network = network
    }
    
    /// Simulates fetching series using the mock network service.
    func getSeries(ts: String, hash: String, apikey: String, characterID: Int) async throws -> [MarvelSeries] {
        return try await network.getSeries(ts: ts, hash: hash, apikey: apikey, characterID: characterID)
    }
}
