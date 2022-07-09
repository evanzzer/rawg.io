//
//  FavoriteInjection.swift
//  Rawg.io
//
//  Created by Leafy on 07/07/22.
//

import Foundation
import Core
import Favorite
import Swinject

// swiftlint:disable force_cast
final class FavoriteInjection: NSObject {
    func provideFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == [GamesModel] {
        return Interactor(repository: Assembler.sharedAssembler.resolver.resolve(
            GetFavoriteRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>.self
        )!) as! U
    }
}
