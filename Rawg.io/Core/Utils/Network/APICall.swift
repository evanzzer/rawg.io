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
            switch self {
            case .popular: return "\(API.baseUrl)?key=\(API_KEY)&page_size=\(PAGE_SIZE)"
            case .search(let query):
                var components = URLComponents(string: API.baseUrl)!
                components.queryItems = [
                    URLQueryItem(name: "key", value: API_KEY),
                    URLQueryItem(name: "page_size", value: SEARCH_SIZE),
                    URLQueryItem(name: "search", value: query)
                ]
                return components.string!
            case .details(let id): return "\(API.baseUrl)/\(id)?key=\(API_KEY)"
            }
        }
    }
}
