//
//  APICall.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation

struct API {
    static let baseUrl = "https://api.rawg.io/api/games"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Gets: Endpoint {
        case popular
        case search(query: String)
        case details(id: Int)
        
        public var url: String {
            let PAGE_SIZE = "25"
            let SEARCH_SIZE = "25"
            
            var apiKey: String {
                guard let filePath = Bundle.main.path(forResource: "Rawg.io", ofType: "plist") else {
                    fatalError("Couldn't find file 'Rawg.io.plist'.")
                }
                let plist = NSDictionary(contentsOfFile: filePath)
                guard let value = plist?.object(forKey: "API_KEY") as? String else {
                    fatalError("Couldn't find key 'API_KEY' in 'Rawg.io.plist'.")
                }
                return value
            }
            
            switch self {
            case .popular: return "\(API.baseUrl)?key=\(apiKey)&page_size=\(PAGE_SIZE)"
            case .search(let query):
                var components = URLComponents(string: API.baseUrl)!
                components.queryItems = [
                    URLQueryItem(name: "key", value: apiKey),
                    URLQueryItem(name: "page_size", value: SEARCH_SIZE),
                    URLQueryItem(name: "search", value: query)
                ]
                return components.string!
            case .details(let id): return "\(API.baseUrl)/\(id)?key=\(apiKey)"
            }
        }
    }
}
