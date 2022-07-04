//
//  GamesModel.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation

struct GamesModel: Identifiable {
    let id: Int
    let name: String
    let released: String?
    let imageUrl: String?
    let rating: Double
}
