//
//  GamesDetail.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation

struct GamesDetailModel {
    let id: Int
    let name: String
    let released: String
    let imageUrl: String?
    let website: String
    let rating: Double
    let alternativeNames: [String]
    let platforms: String
    let genres: String
    let publishers: String
    let description: String
}
