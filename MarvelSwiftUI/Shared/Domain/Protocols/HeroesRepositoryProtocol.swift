import Foundation

/// A protocol that defines the requirements for a repository handling heroes data.
protocol HeroesRepositoryProtocol {
    
    /// Retrieves a list of heroes from the repository.
    ///
    /// - Parameters:
    ///   - ts: A timestamp used for authentication.
    ///   - hash: The MD5 hash generated from the timestamp, private key, and public key.
    ///   - apikey: The public key provided by the Marvel API.
    ///   - orderBy: A parameter to specify the sorting order of the results (e.g., "-modified").
    ///
    /// - Returns: An array of `Hero` objects.
    /// - Throws: An error if the network request fails or the data cannot be decoded.
    func getHeroes(ts: String, hash: String, apikey: String, orderBy: String) async throws -> [Hero]
}
