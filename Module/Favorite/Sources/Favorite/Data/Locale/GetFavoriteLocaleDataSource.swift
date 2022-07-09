//
//  File.swift
//  
//
//  Created by Leafy on 06/07/22.
//

import Foundation
import Core
import Combine
import RealmSwift

public struct GetFavoriteLocaleDataSource: LocaleDataSource {
    public typealias Request = Any
    public typealias Response = GamesEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[GamesEntity], Error> {
        return Future<[GamesEntity], Error> { completion in
            let games: Results<GamesEntity> = {
                _realm.objects(GamesEntity.self)
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(games.toArray(ofType: GamesEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entity: GamesEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: Int) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func delete(id: Int) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}
