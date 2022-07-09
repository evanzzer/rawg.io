//
//  File.swift
//  
//
//  Created by Leafy on 06/07/22.
//

import Combine
import Core

public struct GetDetailRepository<GetRemoteDataSource: RemoteDataSource,
                                  Transformer: Mapper>: Repository
where GetRemoteDataSource.Request == String, GetRemoteDataSource.Response == DetailResponse,
      Transformer.Object == DetailResponse, Transformer.Transformed == DetailModel {
    public typealias Request = String
    public typealias Response = DetailModel
    
    private let _remoteDataSource: GetRemoteDataSource
    private let _mapper: Transformer
    
    public init(remoteDataSource: GetRemoteDataSource, mapper: Transformer) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<DetailModel, Error> {
        return _remoteDataSource.execute(request: request)
            .map { _mapper.transform(object: $0) }
            .eraseToAnyPublisher()
    }
}
