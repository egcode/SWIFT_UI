//
//  CodableBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Nick Sarno on 4/10/21.
//

import SwiftUI

// Codable = Decodable + Encodable
/*
 
 Automaticaly convert JSON to struct
 https://app.quicktype.io/
 
 */
struct CustomerModel: Identifiable, Codable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        
        guard let data = getJSONData() else { return }
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
    }
    
    func getJSONData() -> Data? {
        
        let customer = CustomerModel(id: "111", name: "Emily", points: 100, isPremium: false)
        let jsonData = try? JSONEncoder().encode(customer)
//        let dictionary: [String:Any] = [
//            "id" : "12345",
//            "name" : "Joe",
//            "points" : 5,
//            "isPremium" : true
//        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        return jsonData
    }
    
}

struct CodableBootcamp: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

struct CodableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp()
    }
}
