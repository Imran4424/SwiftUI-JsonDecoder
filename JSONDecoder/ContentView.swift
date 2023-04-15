//
//  ContentView.swift
//  JSONDecoder
//
//  Created by Shah Md Imran Hossain on 15/4/23.
//

import SwiftUI

struct Address: Codable {
    let street: String
    let city: String
}

struct User: Codable {
    let name: String
    let address: Address
}

struct ContentView: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
            {
                "name": "Hugh Jackman",
                "address": {
                    "street": "555, Hugh Jackman Avenue",
                    "city": "Nashvile"
                }
            }
            """
            let data = Data(input.utf8)
            
            guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                print("data decoding failed")
                return
            }
            
            print(user.address.street)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
