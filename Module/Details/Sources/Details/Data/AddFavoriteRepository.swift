import Combine
import Core
import Favorite

public struct AddFavoriteRepository<FavLocaleDataSource: LocaleDataSource,
                                    Transformer: Mapper>: Repository
where FavLocaleDataSource.Response == GamesEntity,
      Transformer.Object == GamesModel, Transformer.Transformed == GamesEntity {
    public typealias Request = GamesModel
    public typealias Response = Bool
    
    private let _localeDataSource: FavLocaleDataSource
    private let _mapper: Transformer
    
    public init(localeDataSource: FavLocaleDataSource, mapper: Transformer) {
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: GamesModel?) -> AnyPublisher<Bool, Error> {
        if let model = request {
            return _localeDataSource.add(entity: _mapper.transform(object: model))
                .eraseToAnyPublisher()
        } else {
            return Future<Bool, Error> { completion in
                completion(.failure(DatabaseError.requestFailed))
            }.eraseToAnyPublisher()
        }
    }
}
