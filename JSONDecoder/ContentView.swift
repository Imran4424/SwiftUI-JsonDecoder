//
//  ContentView.swift
//  JSONDecoder
//
//  Created by Shah Md Imran Hossain on 15/4/23.
//

import SwiftUI

class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name = "Imran Hossain"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct Response: Codable {
    var results: [Result]
}

struct ContentView: View {
//    @State private var results = [Result]()
    
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"))
            .frame(width: 200, height: 200) // frame will not work for async image
    }
}

// MARK: - Async Methods
extension ContentView {
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else {
                print("Invalid decoded response")
                return
            }
            
//            results = decodedResponse.results
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
