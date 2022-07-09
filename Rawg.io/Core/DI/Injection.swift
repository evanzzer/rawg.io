//
//  Injection.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation
import RealmSwift
import Swinject
import Games
import Favorite
import Details

// swiftlint:disable force_try
final class RealmAssembly: Assembly {
    func assemble(container: Container) {
        let realm = try! Realm()
        container.register(Realm.self, factory: { _ in realm }).inObjectScope(.container)
    }
}

final class GamesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GetGamesRemoteDataSource.self, factory: { _ in GetGamesRemoteDataSource() })
            .inObjectScope(.container)
        container.register(Games.GamesTransformer.self, factory: { _ in Games.GamesTransformer() })
        container.register(GetGamesRepository.self, factory: { r in
            return GetGamesRepository<GetGamesRemoteDataSource, Games.GamesTransformer>(
                remoteDataSource: r.resolve(GetGamesRemoteDataSource.self)!,
                mapper: r.resolve(Games.GamesTransformer.self)!
            )
        })
    }
}

final class FavoriteAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GetFavoriteLocaleDataSource.self, factory: { r in
            return GetFavoriteLocaleDataSource(realm: r.resolve(Realm.self)!)
        }).inObjectScope(.container)
        container.register(FavoriteTransformer.self, factory: { _ in FavoriteTransformer() })
        container.register(GetFavoriteRepository.self, factory: { r in
            return GetFavoriteRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>(
                localeDataSource: r.resolve(GetFavoriteLocaleDataSource.self)!,
                mapper: r.resolve(FavoriteTransformer.self)!
            )
        })
    }
}

final class DetailAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GetDetailRemoteDataSource.self, factory: { _ in GetDetailRemoteDataSource() })
            .inObjectScope(.container)
        container.register(FavoriteDetailLocaleDataSource.self, factory: { r in
            return FavoriteDetailLocaleDataSource(realm: r.resolve(Realm.self)!)
        }).inObjectScope(.container)
        container.register(DetailTransformer.self, factory: { _ in DetailTransformer() })
        container.register(Details.GamesTransformer.self, factory: { _ in Details.GamesTransformer() })
        container.register(GetDetailRepository.self, factory: { r in
            return GetDetailRepository<GetDetailRemoteDataSource, DetailTransformer>(
                remoteDataSource: r.resolve(GetDetailRemoteDataSource.self)!, mapper: r.resolve(DetailTransformer.self)!
            )
        })
        container.register(AddFavoriteRepository.self, factory: { r in
            return AddFavoriteRepository<FavoriteDetailLocaleDataSource, Details.GamesTransformer>(
                localeDataSource: r.resolve(FavoriteDetailLocaleDataSource.self)!,
                mapper: r.resolve(Details.GamesTransformer.self)!
            )
        })
        container.register(GetFavoriteStatusRepository.self, factory: { r in
            return GetFavoriteStatusRepository<FavoriteDetailLocaleDataSource>(
                localeDataSource: r.resolve(FavoriteDetailLocaleDataSource.self)!
            )
        })
        container.register(DeleteFavoriteRepository.self, factory: { r in
            return DeleteFavoriteRepository<FavoriteDetailLocaleDataSource>(
                localeDataSource: r.resolve(FavoriteDetailLocaleDataSource.self)!
            )
        })
    }
}

extension Assembler {
    static let sharedAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler([
            RealmAssembly(),
            GamesAssembly(),
            FavoriteAssembly(),
            DetailAssembly()
        ], container: container)
        
        return assembler
    }()
}
