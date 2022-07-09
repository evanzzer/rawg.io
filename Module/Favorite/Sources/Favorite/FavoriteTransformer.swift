//
//  File.swift
//  
//
//  Created by Leafy on 06/07/22.
//

import Core

public struct FavoriteTransformer: Mapper {
    public typealias Object = [GamesEntity]
    public typealias Transformed = [GamesModel]
    
    public init() {}
    
    public func transform(object: [GamesEntity]) -> [GamesModel] {
        return object.map { result in
            return GamesModel(
                id: result.id,
                name: result.name,
                released: result.released,
                imageUrl: result.imageUrl,
                rating: result.rating
            )
        }
    }
}
