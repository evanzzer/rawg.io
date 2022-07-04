//
//  DataRepository.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation
import Combine

final class DataRepository: NSObject {
    fileprivate let locale: LocaleProtocol
    fileprivate let remote: RemoteProtocol
    
    init(locale: LocaleProtocol, remote: RemoteProtocol) {
        self.locale = locale
        self.remote = remote
    }
}

extension DataRepository: DataSource {
    func getGamesList(search: String = "") -> AnyPublisher<[GamesModel], Error> {
        return self.remote.getGamesList(search: search)
            .map { ModelMapper.mapGamesResponseToModel(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getGamesDetail(id: Int) -> AnyPublisher<GamesDetailModel, Error> {
        return self.remote.getGamesDetail(id: id)
            .map { ModelMapper.mapGamesDetailResponseToModel(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getAllFavorites() -> AnyPublisher<[GamesModel], Error> {
        return self.locale.getAllFavorites()
            .map { ModelMapper.mapGamesEntityToModel(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getFavoriteGameById(id: Int) -> AnyPublisher<Bool, Error> {
        return self.locale.getFavoriteGameById(id: id)
            .eraseToAnyPublisher()
    }
    
    func insertFavoriteGame(
        id: Int, name: String, released: String?, imageUrl: String?, rating: Double
    ) -> AnyPublisher<Any?, Error> {
        return self.locale.insertFavoriteGame(
            id: id, name: name, released: released, imageUrl: imageUrl, rating: rating
        ).eraseToAnyPublisher()
    }
    
    func removeFavoriteGame(id: Int) -> AnyPublisher<Any?, Error> {
        return self.locale.removeFavoriteGame(id: id)
            .eraseToAnyPublisher()
    }
}
