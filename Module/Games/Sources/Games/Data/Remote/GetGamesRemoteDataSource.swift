//
//  File.swift
//  
//
//  Created by Leafy on 06/07/22.
//

import Foundation
import Core
import Combine
import Alamofire

public struct GetGamesRemoteDataSource: RemoteDataSource {
    public typealias Request = String
    public typealias Response = [GameResponse]
    
    public init() {}
    
    public func execute(request: String?) -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in
            if let url = URL(string: request ?? "") {
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
            } else {
                completion(.failure(URLError.invalidURL))
            }
        }.eraseToAnyPublisher()
    }
}
