import SwiftUI
import Combine

// Model representing a financial transaction
struct Transaction {
    let timestamp: any UnsignedInteger
    let name: String
    let amount: Double
    
    // Factory method to create a Transaction from a string
    static func from_str(s: String) -> Transaction {
        let splits = s.split(separator: ":")
        if
            let timestamp = UInt(splits[0]),
            let amount = Double(splits[2]) {
            
            return Transaction(timestamp: timestamp, name: String(splits[1]), amount: amount)
        } else {
            print("using default")
            return Transaction(timestamp: 1 as! (any UnsignedInteger), name: "null", amount: 0)
        }
    }
}

// Manager for API-related functionalities
class APIManager {
    // Shared instance of the APIManager
    static let shared = APIManager()
    
    // Bearer token for authentication
    static var bearer = "bearer_nullBearer"
    
    // Convert a timestamp to a formatted string
    func as_converted(timestamp: TimeInterval, format: String) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let fmt = DateFormatter()
        fmt.dateFormat = format
        
        return fmt.string(from: date)
    }
    
    // Drop all transactions associated with the current bearer
    func drop_all() {
        guard let url = URL(string: "http://localhost:8000/dump/\(APIManager.bearer)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let _res = response as? HTTPURLResponse {
                // Operation successful
            }
        }.resume()
    }
    
    // Record a transaction with a description and amount
    func transaction(forWhat: String, amount: Double) {
        guard let url = URL(string: "http://localhost:8000/transact") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(APIManager.bearer, forHTTPHeaderField: "x-bearer")
        request.httpBody = "\(forWhat);\(amount)".data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let res = response as? HTTPURLResponse, let dat = data {
                print("\(res.statusCode) : \(String(data: dat, encoding: .utf8))")
            }
        }.resume()
    }
    
    // Retrieve transactions associated with the current bearer
    func get_transactions(completion: @escaping ([Transaction]) -> Void) {
        guard let url = URL(string: "http://localhost:8000/transactions/\(APIManager.bearer)") else {
            print("Invalid URL")
            return completion([])
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion([])
            }
            if let _ = response as? HTTPURLResponse,
               let hd = data,
               let rs = String(data: hd, encoding: .utf8) {
                var ret: [Transaction] = [];
                let splits = rs.split(separator: "\n")
                for split in splits {
                    print("Appending \(Transaction.from_str(s: String(split)))")
                    ret.append(Transaction.from_str(s: String(split)))
                }
                completion(ret)
            } else {
                completion([])
            }
        }.resume()
    }
}
