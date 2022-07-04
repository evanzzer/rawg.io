//
//  LocaleDataSourceProtocol.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Combine

protocol LocaleProtocol: AnyObject {
    func getAllFavorites() -> AnyPublisher<[GamesEntity], Error>
    func getFavoriteGameById(id: Int) -> AnyPublisher<Bool, Error>
    func insertFavoriteGame(
        id: Int, name: String, released: String?, imageUrl: String?, rating: Double
    ) -> AnyPublisher<Any?, Error>
    func removeFavoriteGame(id: Int) -> AnyPublisher<Any?, Error>
}
