//
//  File.swift
//  
//
//  Created by Leafy on 06/07/22.
//

import Combine
import Core

public struct GetFavoriteRepository<FavLocaleDataSource: LocaleDataSource, Transformer: Mapper>: Repository
where FavLocaleDataSource.Response == GamesEntity,
      Transformer.Object == [GamesEntity], Transformer.Transformed == [GamesModel] {
    public typealias Request = Any
    public typealias Response = [GamesModel]
    
    private let _localeDataSource: FavLocaleDataSource
    private let _mapper: Transformer
    
    public init(localeDataSource: FavLocaleDataSource, mapper: Transformer) {
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[GamesModel], Error> {
        return _localeDataSource.list(request: nil)
            .map { _mapper.transform(object: $0) }
            .eraseToAnyPublisher()
    }
}
