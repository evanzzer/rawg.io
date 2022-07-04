//
//  SearchInteractor.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation
import Combine

class SearchInteractor: SearchUseCase {
    private let repository: DataSource
    
    required init(repository: DataSource) {
        self.repository = repository
    }
    
    func getGamesList(search: String = "") -> AnyPublisher<[GamesModel], Error> {
        return repository.getGamesList(search: search)
    }
}
