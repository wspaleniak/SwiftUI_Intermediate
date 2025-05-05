//
//  CodableExample.swift
//  SwiftUIIntermediate
//
//  Created by Wojciech Spaleniak on 07/10/2024.
//



// MARK: - NOTES

// MARK: 21 - Codable, Decodable, and Encodable in Swift
///
/// - ONLY CODE



// MARK: - CODE

import SwiftUI

struct CodableExampleCustomer: Identifiable, Codable {
    let id: String
    let userName: String
    let userPoints: Int
    let isPremium: Bool
    
    /// Potrzebne gdy klucze JSONa mają inny sposób zapisu niż stosujemy w kodzie
    /// Np. podczas użycia `snake_case` zamiast `camelCase` w JSONie
    //
    // OPCJA 1
    // enum CodingKeys: String, CodingKey {
    //     case id = "id"
    //     case userName = "user_name"
    //     case userPoints = "user_points"
    //     case isPremium = "is_premium"
    // }
    
    /// Gdy używamy protokołu `Codable` cały kod poniżej jest tworzony za nas z automatu
    /// Nie musimy tego pisać ponieważ to się dzieje "pod spodem"
    /// Poszczególny kod jest również tworzony podczas używania protokołów `Decodable` oraz `Encodable`
    //
    // init(id: String, userName: String, userPoints: Int, isPremium: Bool) {
    //     self.id = id
    //     self.userName = userName
    //     self.userPoints = userPoints
    //     self.isPremium = isPremium
    // }
    //
    // init(from decoder: Decoder) throws {
    //     let container = try decoder.container(keyedBy: CodingKeys.self)
    //     self.id = try container.decode(String.self, forKey: .id)
    //     self.userName = try container.decode(String.self, forKey: .userName)
    //     self.userPoints = try container.decode(Int.self, forKey: .userPoints)
    //     self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
    // }
    //
    // func encode(to encoder: any Encoder) throws {
    //     var container = encoder.container(keyedBy: CodingKeys.self)
    //     try container.encode(id, forKey: .id)
    //     try container.encode(userName, forKey: .userName)
    //     try container.encode(userPoints, forKey: .userPoints)
    //     try container.encode(isPremium, forKey: .isPremium)
    // }
}



final class CodableExampleViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published
    private(set) var customer: CodableExampleCustomer?
    
    // MARK: - Init
    
    init() {
        getData()
    }
    
    // MARK: - Methods
    
    private func getData() {
        guard let data = getJSONData() else {
            return
        }
        // OPCJA 1
        // if let localData = try? JSONSerialization.jsonObject(with: data),
        //    let dictionary = localData as? [String: Any],
        //    let id = dictionary["id"] as? String,
        //    let userName = dictionary["user_name"] as? String,
        //    let userPoints = dictionary["user_points"] as? Int,
        //    let isPremium = dictionary["is_premium"] as? Bool {
        //     customer = Customer(
        //         id: id,
        //         userName: userName,
        //         userPoints: userPoints,
        //         isPremium: isPremium
        //     )
        // }
        
        // OPCJA 2
        customer = try? JSONDecoder().decode(CodableExampleCustomer.self, from: data)
    }
    
    private func getJSONData() -> Data? {
        // OPCJA 1
        // let json: [String: Any] = [
        //     "id": "1",
        //     "user_name": "Johnny",
        //     "user_points": 100,
        //     "is_premium": true
        // ]
        // return try? JSONSerialization.data(withJSONObject: json)
        
        // OPCJA 2
        let customer = CodableExampleCustomer(
            id: "1",
            userName: "Johnny",
            userPoints: 100,
            isPremium: true
        )
        return try? JSONEncoder().encode(customer)
    }
}



struct CodableExample: View {
    
    // MARK: - Properties
    
    @StateObject
    private var viewModel = CodableExampleViewModel()
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            if let customer = viewModel.customer {
                Text(customer.id)
                Text(customer.userName)
                Text(customer.userPoints.description)
                Text(customer.isPremium.description)
            }
        }
        .font(.largeTitle)
    }
}

// MARK: - Preview

#Preview {
    CodableExample()
}
