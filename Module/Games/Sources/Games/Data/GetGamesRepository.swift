//
//  File.swift
//  
//
//  Created by Leafy on 06/07/22.
//

import Combine
import Core

public struct GetGamesRepository<GetRemoteDataSource: RemoteDataSource,
                                 Transformer: Mapper>: Repository
where GetRemoteDataSource.Request == String, GetRemoteDataSource.Response == [GameResponse],
      Transformer.Object == [GameResponse], Transformer.Transformed == [GamesModel] {
    public typealias Request = String
    public typealias Response = [GamesModel]
    
    private let _remoteDataSource: GetRemoteDataSource
    private let _mapper: Transformer
    
    public init(remoteDataSource: GetRemoteDataSource, mapper: Transformer) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[GamesModel], Error> {
        return _remoteDataSource.execute(request: request)
            .map { _mapper.transform(object: $0) }
            .eraseToAnyPublisher()
    }
}
