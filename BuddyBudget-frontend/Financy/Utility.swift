import Foundation
import CryptoKit

extension String {
    func sha256() -> String {
        let inputData = Data(self.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashedString = hashedData.map { String(format: "%02hhx", $0) }.joined()
        return hashedString
    }
}
