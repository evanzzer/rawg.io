//
//  File.swift
//
//
//  Created by Leafy on 06/07/22.
//

import Core
import Favorite

public struct GamesTransformer: Mapper {
    public typealias Object = GamesModel
    public typealias Transformed = GamesEntity
    
    public init() {}
    
    public func transform(object: GamesModel) -> GamesEntity {
        let result = GamesEntity()
        result.id = object.id
        result.name = object.name
        result.released = object.released
        result.imageUrl = object.imageUrl
        result.rating = object.rating
        return result
    }
}

public struct DetailTransformer: Mapper {
    public typealias Object = DetailResponse
    public typealias Transformed = DetailModel
    
    public init() {}
    
    public func transform(object: DetailResponse) -> DetailModel {
        return DetailModel(
            id: object.id,
            name: object.name,
            released: checkIfStringIsEmpty(object.released),
            imageUrl: object.imageUrl,
            website: checkIfStringIsEmpty(object.website),
            rating: object.rating,
            alternativeNames: object.alternativeNames,
            platforms: (object.platforms?.isEmpty ?? true) ? "N/A" : object.platforms!
                .map { platform in platform.details.name }
                .joined(separator: ", "),
            genres: (object.genres?.isEmpty ?? true) ? "N/A" : object.genres!
                .map { genre in genre.name }
                .joined(separator: ", "),
            publishers: (object.publishers?.isEmpty ?? true) ? "N/A" : object.publishers!
                .map { publisher in publisher.name }
                .joined(separator: ", "),
            description: checkIfStringIsEmpty(object.description)
        )
    }
}

extension DetailTransformer {
    private func checkIfStringIsEmpty(_ input: String?) -> String {
        return (input != nil && !input!.isEmpty) ? input! : "N/A"
    }
}
