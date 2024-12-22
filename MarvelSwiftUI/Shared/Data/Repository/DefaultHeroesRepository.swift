import Foundation

/// Implementation of `NetworkHeroesProtocol` for fetching heroes from the Marvel API.
final class DefaultHeroesRepository: NetworkHeroesProtocol {
    
    private var network: NetworkHeroesProtocol
    
    /// Initializes the repository with a network service.
    init(network: NetworkHeroesProtocol = NetworkHeroes()) {
        self.network = network
    }
    
    /// Fetches heroes using the provided network service.
    func getHeroes(ts: String, hash: String, apikey: String, orderBy: String) async throws -> [Hero] {
        return try await network.getHeroes(ts: ts, hash: hash, apikey: apikey, orderBy: orderBy)
    }
}

/// Mock implementation of `NetworkHeroesProtocol` for testing purposes.
final class DefaultHeroesRepositoryMock: NetworkHeroesProtocol {
    
    private var network: NetworkHeroesProtocol
    
    /// Initializes the mock repository with a mock network service.
    init(network: NetworkHeroesProtocol = NetworkHeroesMock()) {
        self.network = network
    }
    
    /// Simulates fetching heroes using the mock network service.
    func getHeroes(ts: String, hash: String, apikey: String, orderBy: String) async throws -> [Hero] {
        return try await network.getHeroes(ts: ts, hash: hash, apikey: apikey, orderBy: orderBy)
    }
}
