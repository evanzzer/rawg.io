//
//  FavoriteInteractor.swift
//  Rawg.io
//
//  Created by Leafy on 25/06/22.
//

import Foundation
import Combine

class FavoriteInteractor: FavoriteUseCase {
    private let repository: DataSource
    
    required init(repository: DataSource) {
        self.repository = repository
    }
    
    func getAllFavorites() -> AnyPublisher<[GamesModel], Error> {
        return repository.getAllFavorites()
    }
}
