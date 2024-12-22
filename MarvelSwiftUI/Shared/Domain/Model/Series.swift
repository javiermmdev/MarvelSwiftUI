import Foundation

/// Model representing a Marvel series with the required fields
struct MarvelSeries: Decodable {
    let id: Int
    let title: String
    let description: String?
    let startYear: Int
    let endYear: Int
    let rating: String?
    let type: String?
    let thumbnail: Thumbnail

    /// Nested model for handling thumbnail details
    struct Thumbnail: Decodable {
        let path: String
        let `extension`: String
    }
}

/// Model representing the complete Marvel API response for series
struct MarvelSeriesResponse: Decodable {
    let code: Int
    let status: String
    let data: MarvelSeriesData
}

/// Primary data structure within the Marvel API response for series
struct MarvelSeriesData: Decodable {
    let results: [MarvelSeries]
}
