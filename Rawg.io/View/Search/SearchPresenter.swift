//
//  GameObserver.swift
//  Rawg.io
//
//  Created by Leafy on 07/06/22.
//

import SwiftUI
import Combine

class SearchPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    private var queryPublisher: AnyCancellable?
    
    private let router = SearchRouter()
    private let searchUseCase: SearchUseCase
    
    @Published var query = ""
    @Published var list: [GamesModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
        self.queryPublisher = $query
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .sink(receiveValue: { search in
                self.retrieveData(query: search)
            })
    }
    
    func retrieveData(query search: String = "") {
        loadingState = true
        searchUseCase.getGamesList(search: search)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { list in
                self.list = list
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for id: Int,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeDetailView(for: id)) {
            content()
        }.opacity(0.0)
    }
}
