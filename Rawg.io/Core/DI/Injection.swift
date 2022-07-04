//
//  Injection.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation
import RealmSwift
import Swinject

final class DataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RemoteProtocol.self, factory: { _ in RemoteDataSource() }).inObjectScope(.container)
        container.register(LocaleProtocol.self, factory: { _ in
            let realm = try? Realm()
            return LocaleDataSource(realm: realm)
        }).inObjectScope(.container)
        container.register(DataSource.self, factory: { r in
            DataRepository(locale: r.resolve(LocaleProtocol.self)!, remote: r.resolve(RemoteProtocol.self)!)
        }).inObjectScope(.container)
    }
}

final class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SearchUseCase.self, factory: { r in
            SearchInteractor(repository: r.resolve(DataSource.self)!)
        })
        container.register(FavoriteUseCase.self, factory: { r in
            FavoriteInteractor(repository: r.resolve(DataSource.self)!)
        })
        container.register(DetailUseCase.self, factory: { r in
            DetailInteractor(repository: r.resolve(DataSource.self)!)
        })
    }
}

extension Assembler {
    static let sharedAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler([
            DataAssembly(),
            UseCaseAssembly()
        ], container: container)
        
        return assembler
    }()
}
