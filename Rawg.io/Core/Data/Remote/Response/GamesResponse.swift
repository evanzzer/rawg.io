//
//  Game.swift
//  Rawg.io
//
//  Created by Leafy on 07/06/22.
//

struct GamesResponse: Codable {
    let list: [GameResponse]
    
    enum CodingKeys: String, CodingKey {
        case list = "results"
    }
}

struct GameResponse: Identifiable, Codable {
    let id: Int
    let name: String
    let released: String?
    let imageUrl: String?
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case imageUrl = "background_image"
        case rating
    }
}
