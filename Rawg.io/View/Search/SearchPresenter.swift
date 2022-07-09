//
//  File.swift
//
//
//  Created by Leafy on 06/07/22.
//

import SwiftUI
import Combine
import Core
import Games

public class SearchPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private var queryPublisher: AnyCancellable?
    
    typealias GetSearchUseCase = Interactor<String, [GamesModel], GetGamesRepository<
            GetGamesRemoteDataSource, GamesTransformer>>
    private let useCase: GetSearchUseCase
    
    @Published public var query = ""
    @Published public var list: [GamesModel] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(useCase: GetSearchUseCase) {
        self.useCase = useCase
        queryPublisher = $query
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .sink(receiveValue: { search in
                self.getList(request: search)
            })
    }
    
    public func getList(request: String = "") {
        isLoading = true
        self.useCase.execute(request: request.isEmpty ? Endpoints.Gets.popular.url
                             : Endpoints.Gets.search(query: request).url)
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
