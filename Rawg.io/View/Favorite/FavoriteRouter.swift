//
//  FavoriteRouter.swift
//  Rawg.io
//
//  Created by Leafy on 25/06/22.
//

import SwiftUI
import Swinject

class FavoriteRouter {
    func makeDetailView(for id: Int) -> some View {
        let injection = DetailInjection.init()
        return DetailView(id: id, presenter: DetailPresenter(
            getDetailUseCase: injection.provideDetails(),
            addFavoriteUseCase: injection.provideAddItem(),
            getFavoriteStateUseCase: injection.provideFavoriteStatus(),
            deleteFavoriteUseCase: injection.provideDeleteItem()
        ))
    }
}
