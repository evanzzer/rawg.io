//
//  SearchUseCase.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation
import Combine

protocol SearchUseCase {
    func getGamesList(search: String) -> AnyPublisher<[GamesModel], Error>
}
