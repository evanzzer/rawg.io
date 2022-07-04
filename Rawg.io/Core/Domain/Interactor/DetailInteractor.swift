//
//  DetailInteractor.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation
import Combine

class DetailInteractor: DetailUseCase {
    private let repository: DataSource
    
    required init(repository: DataSource) {
        self.repository = repository
    }
    
    func getGamesDetail(id: Int) -> AnyPublisher<GamesDetailModel, Error> {
        return repository.getGamesDetail(id: id)
    }
    
    func getFavoriteGameById(id: Int) -> AnyPublisher<Bool, Error> {
        return repository.getFavoriteGameById(id: id)
    }
    
    func insertFavoriteGame(
        id: Int, name: String, released: String?, imageUrl: String?, rating: Double
    ) -> AnyPublisher<Any?, Error> {
        return repository.insertFavoriteGame(id: id, name: name, released: released, imageUrl: imageUrl, rating: rating)
    }
    
    func removeFavoriteGame(id: Int) -> AnyPublisher<Any?, Error> {
        return repository.removeFavoriteGame(id: id)
    }
}
