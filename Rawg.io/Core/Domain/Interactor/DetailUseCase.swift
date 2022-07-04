//
//  DetailUsecase.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation
import Combine

protocol DetailUseCase {
    func getGamesDetail(id: Int) -> AnyPublisher<GamesDetailModel, Error>
    func getFavoriteGameById(id: Int) -> AnyPublisher<Bool, Error>
    func insertFavoriteGame(
        id: Int, name: String, released: String?, imageUrl: String?, rating: Double
    ) -> AnyPublisher<Any?, Error>
    func removeFavoriteGame(id: Int) -> AnyPublisher<Any?, Error>
}
