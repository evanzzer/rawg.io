//
//  File.swift
//  
//
//  Created by Leafy on 06/07/22.
//

import Foundation
import Core
import Combine
import Favorite
import RealmSwift

public struct FavoriteDetailLocaleDataSource: LocaleDataSource {
    public typealias Request = Any
    public typealias Response = GamesEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[GamesEntity], Error> {
        fatalError()
    }
    
    public func add(entity: GamesEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    _realm.add(entity)
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let games: Int = {
                _realm.objects(GamesEntity.self)
                    .filter("id = \(id)")
                    .count
            }()
            completion(.success(games != 0))
        }.eraseToAnyPublisher()
    }
    
    public func delete(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    let result: Results<GamesEntity> = {
                        _realm.objects(GamesEntity.self)
                            .filter("id = \(id)")
                    }()
                    _realm.delete(result)
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}
