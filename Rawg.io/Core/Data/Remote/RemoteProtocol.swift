//
//  RemoteDataSourceProtocol.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Combine

protocol RemoteProtocol: AnyObject {
    func getGamesList(search: String) -> AnyPublisher<[GameResponse], Error>
    func getGamesDetail(id: Int) -> AnyPublisher<GamesDetailResponse, Error>
}
