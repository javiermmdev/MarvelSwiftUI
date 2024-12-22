import Foundation

/// Protocol for fetching series from the Marvel API.
protocol NetworkSeriesProtocol {
    /// - Parameters:
    ///   - ts: Timestamp for authentication.
    ///   - hash: MD5 hash (ts+privateKey+publicKey).
    ///   - apikey: Marvel public key.
    ///   - characterID: Character ID (Int) to filter their series.
    ///
    /// - Returns: An array of `MarvelSeries`.
    /// - Throws: Network or decoding error.
    func getSeries(ts: String, hash: String, apikey: String, characterID: Int) async throws -> [MarvelSeries]
}

/// Real implementation of the `NetworkSeriesProtocol`.
final class NetworkSeries: NetworkSeriesProtocol {
    func getSeries(ts: String, hash: String, apikey: String, characterID: Int) async throws -> [MarvelSeries] {
        // Obtain the base URL
        guard let baseURL = SecureConstants.apiUrl else {
            throw NetworkError.networkFailure("invalidBaseURL")
        }

        // Convert characterID to String
        let characterIDString = String(characterID)
        
        // Build the URL with parameters
        var components = URLComponents(string: "\(baseURL)\(Endpoints.listSeries.rawValue)")
        components?.queryItems = [
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: apikey),
            URLQueryItem(name: "characters", value: characterIDString) // Using the String version
        ]

        guard let url = components?.url else {
            throw NetworkError.networkFailure("invalidURLComponents")
        }

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = HTTPSMethods.GET

        do {
            // Perform the network call
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.networkFailure("invalidResponse")
            }

            if httpResponse.statusCode == HttpResponseCodes.SUCCESS {
                // Decode the response into MarvelSeriesResponse
                let marvelResponse = try JSONDecoder().decode(MarvelSeriesResponse.self, from: data)
                // Return the array of series
                return marvelResponse.data.results
            } else {
                // If there's an error, attempt to decode it
                if let errorResponse = try? JSONDecoder().decode(APIError.self, from: data) {
                    let errorMessage = "\(errorResponse.message) (Code: \(httpResponse.statusCode))"
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
            // If something fails in the network or decoding
            throw NetworkError.networkFailure(error.localizedDescription)
        }
    }
}

/// Mock implementation of `NetworkSeriesProtocol` for testing.
/// Returns static data simulating the API response.
final class NetworkSeriesMock: NetworkSeriesProtocol {
    func getSeries(ts: String, hash: String, apikey: String, characterID: Int) async throws -> [MarvelSeries] {
        // Mock data for testing
        let mockSeries: [MarvelSeries] = [
            MarvelSeries(
                id: 6381,
                title: "Ender's Shadow: Battle School (2008 - 2009)",
                description: "A strategic battle school scenario featuring Ender Wiggin.",
                startYear: 2008,
                endYear: 2009,
                rating: "5 Stars",
                type: "Action",
                thumbnail: MarvelSeries.Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/c/10/4bb64aaaa9755",
                    extension: "jpg"
                )
            ),
            MarvelSeries(
                id: 7743,
                title: "Enders Shadow: Command School (2009 - 2010)",
                description: "Ender Wiggin moves into the command phases of his training.",
                startYear: 2009,
                endYear: 2010,
                rating: "",
                type: "",
                thumbnail: MarvelSeries.Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                    extension: "jpg"
                )
            )
        ]

        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds delay

        // Return the mocked series
        return mockSeries
    }
}
