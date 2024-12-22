import Foundation

/// A protocol that defines the requirements for fetching heroes from the Marvel API.
protocol NetworkHeroesProtocol {
    /// Retrieves a list of heroes from the Marvel API.
    ///
    /// - Parameters:
    ///   - ts: The `ts` (timestamp) parameter used in authentication.
    ///   - hash: The MD5 hash computed from `ts`, `privateKey`, and `publicKey`.
    ///   - apikey: Your public key provided by Marvel.
    ///   - orderBy: A parameter to specify the order in which results are returned.
    ///
    /// - Returns: A list of decoded `Hero` objects.
    /// - Throws: An error if the network request fails or the response cannot be decoded.
    func getHeroes(ts: String, hash: String, apikey: String, orderBy: String) async throws -> [Hero]
}

/// Implementation of `NetworkHeroesProtocol` for real API calls.
final class NetworkHeroes: NetworkHeroesProtocol {
    /// Fetches heroes from the Marvel API.
    func getHeroes(ts: String, hash: String, apikey: String, orderBy: String) async throws -> [Hero] {
        // Fetch the base URL from secure constants
        guard let baseURL = SecureConstants.apiUrl else {
            throw NetworkError.networkFailure("Invalid Base URL")
        }

        // Build the URL with query parameters
        var components = URLComponents(string: "\(baseURL)\(Endpoints.listHeros.rawValue)")
        components?.queryItems = [
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: apikey),
            URLQueryItem(name: "orderBy", value: orderBy),
        ]

        // Validate the final URL
        guard let url = components?.url else {
            throw NetworkError.networkFailure("invalidBaseURL")
        }

        // Create the request object
        var request = URLRequest(url: url)
        request.httpMethod = HTTPSMethods.GET

        do {
            // Perform the network call
            let (data, response) = try await URLSession.shared.data(for: request)

            // Ensure the response is an HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.networkFailure("invalidResponse")
            }

            if httpResponse.statusCode == HttpResponseCodes.SUCCESS {
                // Decode the successful response into Hero objects
                let marvelResponse = try JSONDecoder().decode(MarvelHeroesResponse.self, from: data)
                return marvelResponse.data.results
            } else {
                // Decode and throw the error message from the API response
                if let errorResponse = try? JSONDecoder().decode(APIError.self, from: data) {
                    let errorMessage =
                        "\(errorResponse.message) (Code: \(httpResponse.statusCode))"
                    throw NetworkError.serverError(
                        statusCode: httpResponse.statusCode,
                        message: errorMessage
                    )
                } else {
                    throw NetworkError.serverError(
                        statusCode: httpResponse.statusCode,
                        message: "unknownError"
                    )
                }
            }
        } catch {
            // Throw a network failure error with a localized description
            throw NetworkError.networkFailure(error.localizedDescription)
        }
    }
}

/// Mock implementation of `NetworkHeroesProtocol` for testing purposes.
final class NetworkHeroesMock: NetworkHeroesProtocol {
    func getHeroes(ts: String, hash: String, apikey: String, orderBy: String) async throws -> [Hero] {
        // Predefined list of heroes for testing
        let heroes: [Hero] = [
            Hero(
                id: 1,
                name: "Iron Man",
                thumbnail: Thumbnail(
                    path: "https://static.wikia.nocookie.net/marveldatabase/images/9/93/Iron_Man_Vol_7_1_Negative_Space_Variant",
                    ext: "jpg"
                )
            ),
            Hero(
                id: 2,
                name: "Spider-Man",
                thumbnail: Thumbnail(
                    path: "https://static.wikia.nocookie.net/marveldatabase/images/d/da/Amazing_Spider-Man_Vol_5_15_Textless",
                    ext: "jpg"
                )
            ),
        ]

        // Simulate a delay to mimic network latency
        try await Task.sleep(nanoseconds: 1_000_000_000)  // 1 second delay

        return heroes
    }
}
