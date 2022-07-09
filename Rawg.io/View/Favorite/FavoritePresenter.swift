//
//  File.swift
//  
//
//  Created by Leafy on 06/07/22.
//

import SwiftUI
import Combine
import Core
import Favorite

public class FavoritePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    typealias GetFavoriteUseCase = Interactor<Any, [GamesModel], GetFavoriteRepository<
        GetFavoriteLocaleDataSource, FavoriteTransformer>>
    private let useCase: GetFavoriteUseCase
    
    @Published public var list: [GamesModel] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(useCase: GetFavoriteUseCase) {
        self.useCase = useCase
    }
    
    public func getList() {
        isLoading = true
        self.useCase.execute(request: nil)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { list in
                self.list = list
            })
            .store(in: &cancellables)
    }
}
