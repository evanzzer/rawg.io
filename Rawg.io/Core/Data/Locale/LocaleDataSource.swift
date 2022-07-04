//
//  LocaleDataSoruce.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation
import Combine
import RealmSwift

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    init(realm: Realm?) {
        self.realm = realm
    }
}

extension LocaleDataSource: LocaleProtocol {
    func getAllFavorites() -> AnyPublisher<[GamesEntity], Error> {
        return Future<[GamesEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GamesEntity> = {
                    realm.objects(GamesEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(games.toArray(ofType: GamesEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavoriteGameById(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                let games: Int = {
                    realm.objects(GamesEntity.self)
                        .filter("id = \(id)")
                        .count
                }()
                completion(.success(games != 0))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func insertFavoriteGame(
        id: Int, name: String, released: String?, imageUrl: String?, rating: Double
    ) -> AnyPublisher<Any?, Error> {
        return Future<Any?, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        let item = GamesEntity()
                        item.id = id
                        item.name = name
                        item.released = released
                        item.imageUrl = imageUrl
                        item.rating = rating
                        realm.add(item)
                        completion(.success(nil))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func removeFavoriteGame(id: Int) -> AnyPublisher<Any?, Error> {
        return Future<Any?, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        let result: Results<GamesEntity> = {
                            realm.objects(GamesEntity.self)
                                .filter("id = \(id)")
                        }()
                        realm.delete(result)
                        completion(.success(nil))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
