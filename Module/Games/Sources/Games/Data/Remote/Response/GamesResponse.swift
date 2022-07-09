//
//  Game.swift
//  Rawg.io
//
//  Created by Leafy on 07/06/22.
//

public struct GamesResponse: Codable {
    let list: [GameResponse]
    
    private enum CodingKeys: String, CodingKey {
        case list = "results"
    }
}

public struct GameResponse: Identifiable, Codable {
    public let id: Int
    public let name: String
    public let released: String?
    public let imageUrl: String?
    public let rating: Double
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case imageUrl = "background_image"
        case rating
    }
}
