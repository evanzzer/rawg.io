//
//  GameDetail.swift
//  Rawg.io
//
//  Created by Leafy on 07/06/22.
//

struct GamesDetailResponse: Codable {
    let id: Int
    let name: String
    let released: String?
    let imageUrl: String?
    let website: String?    
    let rating: Double
    let alternativeNames: [String]
    let platforms: [Platform]?
    let genres: [Genre]?
    let publishers: [Publisher]?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case imageUrl = "background_image"
        case website
        case rating
        case alternativeNames = "alternative_names"
        case platforms = "parent_platforms"
        case genres
        case publishers
        case description = "description_raw"
    }
}

struct Platform: Codable {
    let details: PlatformDetails
    
    enum CodingKeys: String, CodingKey {
        case details = "platform"
    }
}

struct PlatformDetails: Codable {
    let name: String
}

struct Genre: Codable {
    let name: String
}

struct Publisher: Codable {
    let name: String
}
