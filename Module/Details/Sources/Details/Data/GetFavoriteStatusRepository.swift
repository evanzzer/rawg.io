import Combine
import Core
import Favorite

public struct GetFavoriteStatusRepository<FavLocaleDataSource: LocaleDataSource>: Repository
where FavLocaleDataSource.Response == GamesEntity {
    public typealias Request = Int
    public typealias Response = Bool
    
    private let _localeDataSource: FavLocaleDataSource
    
    public init(localeDataSource: FavLocaleDataSource) {
        _localeDataSource = localeDataSource
    }
    
    public func execute(request: Int?) -> AnyPublisher<Bool, Error> {
        return _localeDataSource.get(id: request ?? 0)
            .eraseToAnyPublisher()
    }
}
