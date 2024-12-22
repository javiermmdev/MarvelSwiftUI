import Foundation
import CryptoKit

/// A structure that securely stores encrypted constants for the MarvelSwiftUI application.
/// Note: For demonstration purposes, the symmetric key is hardcoded in this file.
/// In a production environment, this approach should be avoided.
/// The key should never be stored in clear text, and it should not be committed to version control.
struct SecureConstants {
    /// Symmetric key data in Base64 format.
    private static let keyData = Data(base64Encoded: "HtfwAKWMM7URqKb4987fFlRZ1WcheM/s3u0g77nO9HY=")!
    private static let symmetricKey = SymmetricKey(data: keyData)
    
    /// Instance of the decrypter initialized with the symmetric key.
    private static let decrypter = Decrypter(symmetricKey: symmetricKey)

    /// The encrypted URL (in Base64) generated previously using AES.GCM encryption.
    private static let encryptedAPIURL = Data(base64Encoded: "m9vtMYbrN3/32kI5YtyKxtXh0cv/847dCdXYn22GGd+QNx3/PSu5KwG9T+4OHTtzozrIR++z")!
    
    /// The encrypted timestamp (ts) in Base64.
    private static let encryptedTS = Data(base64Encoded: "KlgGZ5epgjFws6c6FEssGHJWy7ChSLba5NhObEw=")!
    
    /// The encrypted hash (in Base64).
    private static let encryptedHash = Data(base64Encoded: "NaJcR6AaHG3oCH1wsp/o7aGamJbQQePoMQpEJyir5LyA05Jx5WW4zxvxGw1NU2rrTK6qXYNS/d/maKPX")!
    
    /// The encrypted API key (in Base64).
    private static let encryptedApiKey = Data(base64Encoded: "oHcqX4JEMl7DeUcyx5c80GTfxngUnI2QaN4GQ+ALrYxM3odyCvnfY3sTP/DkXV35KNRq3T90sth5Cl7v")!

    /// Decrypts and returns the original URL if decryption succeeds.
    static var apiUrl: String? {
        return decrypter.decrypt(encryptedAPIURL)
    }
    
    /// Decrypts and returns the original timestamp (ts) if decryption succeeds.
    static var ts: String? {
        return decrypter.decrypt(encryptedTS)
    }
    
    /// Decrypts and returns the original hash if decryption succeeds.
    static var hashValue: String? {
        return decrypter.decrypt(encryptedHash)
    }
    
    /// Decrypts and returns the original API key if decryption succeeds.
    static var apiKey: String? {
        return decrypter.decrypt(encryptedApiKey)
    }
}
