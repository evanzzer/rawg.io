//
//  RemoteDataSource.swift
//  Rawg.io
//
//  Created by Leafy on 07/06/22.
//

import Foundation
import Alamofire
import Combine

final class RemoteDataSource: NSObject {}

extension RemoteDataSource: RemoteProtocol {
    func getGamesList(search: String = "") -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in
            if let url = URL(string: search.isEmpty
                             ? Endpoints.Gets.popular.url
                             : Endpoints.Gets.search(query: search).url) {
                AF.request(url, requestModifier: { $0.timeoutInterval = 10.0 })
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.list))
                        case .failure(let error):
                            print(error)
                            if error.localizedDescription.contains("The request timed out.") {
                                completion(.failure(URLError.addressUnreachable))
                            } else {
                                completion(.failure(URLError.invalidResponse))
                            }
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getGamesDetail(id: Int) -> AnyPublisher<GamesDetailResponse, Error> {
        return Future<GamesDetailResponse, Error> { completion in
            if let url = URL(string: Endpoints.Gets.details(id: id).url) {
                AF.request(url, requestModifier: { $0.timeoutInterval = 10.0 })
                    .validate()
                    .responseDecodable(of: GamesDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure(let error):
                            if error._code == NSURLErrorTimedOut {
                                completion(.failure(URLError.addressUnreachable))
                            } else {
                                completion(.failure(URLError.invalidResponse))
                            }
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
}
