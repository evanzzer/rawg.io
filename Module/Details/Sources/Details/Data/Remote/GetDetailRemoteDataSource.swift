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

public struct GetDetailRemoteDataSource: RemoteDataSource {
    public typealias Request = String
    public typealias Response = DetailResponse
    
    public init() {}
    
    public func execute(request: String?) -> AnyPublisher<DetailResponse, Error> {
        return Future<DetailResponse, Error> { completion in
            if let url = URL(string: request ?? "") {
                AF.request(url, requestModifier: { $0.timeoutInterval = 10.0 })
                    .validate()
                    .responseDecodable(of: DetailResponse.self) { response in
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
            } else {
                completion(.failure(URLError.invalidURL))
            }
        }.eraseToAnyPublisher()
    }
}
