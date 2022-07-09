//
//  DetailInjection.swift
//  Rawg.io
//
//  Created by Leafy on 07/07/22.
//

import Foundation
import Core
import Favorite
import Details
import Swinject

// swiftlint:disable force_cast
final class DetailInjection: NSObject {
    func provideDetails<U: UseCase>() -> U where U.Request == String, U.Response == DetailModel {
        return Interactor(repository: Assembler.sharedAssembler.resolver.resolve(
            GetDetailRepository<GetDetailRemoteDataSource, DetailTransformer>.self
        )!) as! U
    }

    func provideAddItem<U: UseCase>() -> U where U.Request == GamesModel, U.Response == Bool {
        return Interactor(repository: Assembler.sharedAssembler.resolver.resolve(
            AddFavoriteRepository<FavoriteDetailLocaleDataSource, Details.GamesTransformer>.self
        )!) as! U
    }

    func provideFavoriteStatus<U: UseCase>() -> U where U.Request == Int, U.Response == Bool {
        return Interactor(repository: Assembler.sharedAssembler.resolver.resolve(
            GetFavoriteStatusRepository<FavoriteDetailLocaleDataSource>.self
        )!) as! U
    }

    func provideDeleteItem<U: UseCase>() -> U where U.Request == Int, U.Response == Bool {
        return Interactor(repository: Assembler.sharedAssembler.resolver.resolve(
            DeleteFavoriteRepository<FavoriteDetailLocaleDataSource>.self
        )!) as! U
    }

}
