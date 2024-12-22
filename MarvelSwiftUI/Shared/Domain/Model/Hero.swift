import Foundation

/// Represents a hero retrieved from the Marvel API.
struct Hero: Codable, Identifiable {
    /// The unique identifier for the hero.
    let id: Int?
    
    /// The name of the hero.
    let name: String?
    
    /// The thumbnail image for the hero.
    let thumbnail: Thumbnail?
    
    /// Returns the full URL of the hero's thumbnail.
    ///
    /// - Note: If no thumbnail is available, this property returns an empty string.
    var thumbnailURL: String {
        return thumbnail?.fullImageURL ?? ""
    }
}

/// Represents the thumbnail image for a hero.
struct Thumbnail: Codable {
    /// The base path of the image.
    let path: String?
    
    /// The file extension for the image (e.g., "jpg" or "png").
    let ext: String?
    
    /// Maps the JSON field "extension" to the Swift property "ext".
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
    
    /// Combines the path and extension to form the full image URL.
    var fullImageURL: String? {
        guard let path = path, let ext = ext else {
            return nil
        }
        return "\(path).\(ext)"
    }
}

/// Represents the overall response from the Marvel API for heroes.
struct MarvelHeroesResponse: Codable {
    /// The main data container, which holds the heroes.
    let data: MarvelHeroesDataContainer
}

/// Represents the data container that contains the list of heroes.
struct MarvelHeroesDataContainer: Codable {
    /// An array of heroes retrieved from the API.
    let results: [Hero]
}
