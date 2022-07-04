//
//  ModelMapper.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation

class ModelMapper {
    static func mapGamesResponseToModel(
        input response: [GameResponse]
    ) -> [GamesModel] {
        return response.map { item in
            return GamesModel(
                id: item.id,
                name: item.name,
                released: item.released,
                imageUrl: item.imageUrl,
                rating: item.rating
            )
        }
    }

    static func mapGamesEntityToModel(
        input entity: [GamesEntity]
    ) -> [GamesModel] {
        return entity.map { item in
            return GamesModel(
                id: item.id,
                name: item.name,
                released: item.released,
                imageUrl: item.imageUrl,
                rating: item.rating
            )
        }
    }
    
    static func mapGamesDetailResponseToModel(
        input response: GamesDetailResponse
    ) -> GamesDetailModel {
        return GamesDetailModel(
            id: response.id,
            name: response.name,
            released: checkIfStringIsEmpty(response.released),
            imageUrl: response.imageUrl,
            website: checkIfStringIsEmpty(response.website),
            rating: response.rating,
            alternativeNames: response.alternativeNames,
            platforms: (response.platforms?.isEmpty ?? true) ? "N/A" : response.platforms!
                .map { platform in platform.details.name }
                .joined(separator: ", "),
            genres: (response.genres?.isEmpty ?? true) ? "N/A" : response.genres!
                .map { genre in genre.name }
                .joined(separator: ", "),
            publishers: (response.publishers?.isEmpty ?? true) ? "N/A" : response.publishers!
                .map { publisher in publisher.name }
                .joined(separator: ", "),
            description: checkIfStringIsEmpty(response.description)
        )
    }
}

private func checkIfStringIsEmpty(_ input: String?) -> String {
    return (input != nil && !input!.isEmpty) ? input! : "N/A"
}
