import Foundation

/// A collection of constants representing common HTTP methods and related headers.
/// Using static properties allows easy access without needing to instantiate the type.
struct HTTPSMethods {
    static let POST = "POST"
    
    static let GET = "GET"
    
    static let PUT = "PUT"
    
    static let DELETE = "DELETE"

    /// A parameter used to specify the order in which results are returned.
    /// For example, `"-modified"` sorts the results by modification date in descending order.
    static let ORDER_BY = "-modified"
}
