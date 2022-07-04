//
//  GamesEntity.swift
//  Rawg.io
//
//  Created by Leafy on 25/06/22.
//

import Foundation
import RealmSwift

class GamesEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var imageUrl: String?
    @objc dynamic var name: String = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var released: String? = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
