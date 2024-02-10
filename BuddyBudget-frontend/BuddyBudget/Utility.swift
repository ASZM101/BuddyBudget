import Foundation
import CryptoKit

// Extend the String class with a sha256 method
extension String {
    // Function to calculate the SHA-256 hash of the string
    func sha256() -> String {
        // Convert the string to UTF-8 data
        let inputData = Data(self.utf8)
        
        // Calculate the SHA-256 hash of the data
        let hashedData = SHA256.hash(data: inputData)
        
        // Convert the hashed data to a hexadecimal string
        let hashedString = hashedData.map { String(format: "%02hhx", $0) }.joined()
        
        // Return the resulting hashed string
        return hashedString
    }
}
