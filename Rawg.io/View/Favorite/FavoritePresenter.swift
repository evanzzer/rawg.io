//
//  FavoritePresenter.swift
//  Rawg.io
//
//  Created by Leafy on 25/06/22.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    private let router = FavoriteRouter()
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var list: [GamesModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func retrieveData() {
        loadingState = true
        favoriteUseCase.getAllFavorites()
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
