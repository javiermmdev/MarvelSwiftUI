
import Foundation
import CryptoKit

/// A utility class responsible for decrypting data using a given symmetric key.
final class Decrypter {
    private let symmetricKey: SymmetricKey
    
    /// Initializes the decrypter with the given symmetric key.
    /// - Parameter symmetricKey: The SymmetricKey used to decrypt data.
    init(symmetricKey: SymmetricKey) {
        self.symmetricKey = symmetricKey
    }
    
    /// Attempts to decrypt the given ciphertext using AES.GCM and the symmetric key.
    /// - Parameter ciphertext: The data to be decrypted (must be the combined format from AES.GCM).
    /// - Returns: The decrypted string if successful, or nil if decryption fails.
    func decrypt(_ ciphertext: Data) -> String? {
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: ciphertext)
            let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
