
/// Network error type for handling API-specific errors.
enum NetworkError: Error {
    case serverError(statusCode: Int, message: String)
    case decodingError
    case networkFailure(String)
}


/// Model to decode API error responses.
struct APIError: Codable {
    let code: String
    let message: String
}
