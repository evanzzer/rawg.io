//
//  GamesInjection.swift
//  Rawg.io
//
//  Created by Leafy on 06/07/22.
//

import Foundation
import Core
import Games
import Swinject

// swiftlint:disable force_cast
final class GamesInjection: NSObject {
    func provideGames<U: UseCase>() -> U where U.Request == String, U.Response == [GamesModel] {
        return Interactor(repository: Assembler.sharedAssembler.resolver.resolve(
            GetGamesRepository<GetGamesRemoteDataSource, GamesTransformer>.self
        )!) as! U
    }
}
