//
//  FavoriteUsecase.swift
//  Rawg.io
//
//  Created by Leafy on 25/06/22.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    func getAllFavorites() -> AnyPublisher<[GamesModel], Error>
}
