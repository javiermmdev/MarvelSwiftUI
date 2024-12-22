
import Foundation

///States of Life Cycle
enum Status: Equatable {
    case none, loading, loaded, error(error: String)
}
