//
//  DetailObserver.swift
//  Rawg.io
//
//  Created by Leafy on 07/06/22.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    private let detailUseCase: DetailUseCase
    
    @Published var data: GamesDetailModel?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var isFavorited: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func retrieveData(id: Int) {
        loadingState = true
        detailUseCase.getGamesDetail(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { data in
                self.data = data
            })
            .store(in: &cancellables)
    }
    
    func retrieveFavoriteStatus(id: Int) {
        detailUseCase.getFavoriteGameById(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { isFavorited in self.isFavorited = isFavorited })
            .store(in: &cancellables)
    }
    
    // Insert into database
    func insertToFavoriteList(
        id: Int, name: String, released: String?, imageUrl: String?, rating: Double, _ completion: @escaping() -> Void
    ) {
        detailUseCase.insertFavoriteGame(id: id, name: name, released: released, imageUrl: imageUrl, rating: rating)
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
        detailUseCase.removeFavoriteGame(id: id)
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
