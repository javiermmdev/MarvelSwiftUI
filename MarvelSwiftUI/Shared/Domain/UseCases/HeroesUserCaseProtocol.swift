
import Foundation


/// Fetches heroes from the repository.
///
/// - Parameters:
///   - ts: Timestamp for authentication.
///   - hash: MD5 hash computed from the timestamp, private key, and public key.
///   - apikey: Public key provided by Marvel.
///   - orderBy: Order criteria for the results (e.g., "-modified").
/// - Returns: A list of heroes retrieved from the repository.
/// - Throws: An error if the network call fails.

/// Protocol defining the use case for fetching heroes.
protocol HeroesUserCaseProtocol {

    func getHeroes(ts: String, hash: String, apikey: String, orderBy: String) async throws -> [Hero]
}

/// Implementation of the Heroes use case.
final class HeroesUserCase: HeroesUserCaseProtocol {
    
    private let repo: NetworkHeroesProtocol
    
    /// Initializes the use case with a repository.
    ///
    /// - Parameter repo: The repository implementing `NetworkHeroesProtocol`.
    ///   Defaults to the `DefaultHeroesRepository` implementation.
    init(repo: NetworkHeroesProtocol = DefaultHeroesRepository()) {
        self.repo = repo
    }
    	
    func getHeroes(ts: String, hash: String, apikey: String, orderBy: String) async throws -> [Hero] {
        return try await repo.getHeroes(ts: ts, hash: hash, apikey: apikey, orderBy: orderBy)
    }
}
