//
//  DetailObserver.swift
//  Rawg.io
//
//  Created by Leafy on 07/06/22.
//

import SwiftUI
import Combine
import Core
import Favorite
import Details

class DetailPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    typealias GetDetailUseCase = Interactor<String, DetailModel, GetDetailRepository<
        GetDetailRemoteDataSource, DetailTransformer>>
    typealias AddFavoriteUseCase = Interactor<GamesModel, Bool, AddFavoriteRepository<
        FavoriteDetailLocaleDataSource, GamesTransformer>>
    typealias GetFavoriteStateUseCase = Interactor<Int, Bool, GetFavoriteStatusRepository<
        FavoriteDetailLocaleDataSource>>
    typealias DeleteFavoriteUseCase = Interactor<Int, Bool, DeleteFavoriteRepository<
        FavoriteDetailLocaleDataSource>>
    
    // 5 Use Cases
    private let getDetailUseCase: GetDetailUseCase
    private let addFavoriteUseCase: AddFavoriteUseCase
    private let getFavoriteStateUseCase: GetFavoriteStateUseCase
    private let deleteFavoriteUseCase: DeleteFavoriteUseCase
    
    @Published var data: DetailModel?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var isFavorited: Bool = false
    
    init(
        getDetailUseCase: GetDetailUseCase,
        addFavoriteUseCase: AddFavoriteUseCase,
        getFavoriteStateUseCase: GetFavoriteStateUseCase,
        deleteFavoriteUseCase: DeleteFavoriteUseCase
    ) {
        self.getDetailUseCase = getDetailUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        self.getFavoriteStateUseCase = getFavoriteStateUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase
    }
    
    func retrieveData(id: Int) {
        isLoading = true
        getDetailUseCase.execute(request: Endpoints.Gets.details(id: id).url)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { data in
                self.data = data
            })
            .store(in: &cancellables)
    }
    
    func retrieveFavoriteStatus(id: Int) {
        getFavoriteStateUseCase.execute(request: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { isFavorited in self.isFavorited = isFavorited })
            .store(in: &cancellables)
    }
    
    // Insert into database
    func insertToFavoriteList(
        id: Int, name: String, released: String?, imageUrl: String?, rating: Double, _ completion: @escaping() -> Void
    ) {
        let gamesModel = GamesModel(id: id, name: name, released: released, imageUrl: imageUrl, rating: rating)
        addFavoriteUseCase.execute(request: gamesModel)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { cmpt in
                switch cmpt {
                case .failure: break
                case .finished:
                    completion()
                }
            }, receiveValue: { _ in self.isFavorited = true })
            .store(in: &cancellables)
    }
    
    func deleteFromFavoriteList(id: Int, _ completion: @escaping() -> Void) {
        deleteFavoriteUseCase.execute(request: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { cmpt in
                switch cmpt {
                case .failure: break
                case .finished:
                    completion()
                }
            }, receiveValue: { _ in self.isFavorited = false })
            .store(in: &cancellables)
    }
}
