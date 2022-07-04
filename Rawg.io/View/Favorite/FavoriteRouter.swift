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
        return DetailView(id: id, presenter: DetailPresenter(
            detailUseCase: Assembler.sharedAssembler.resolver.resolve(DetailUseCase.self)!
        ))
    }
}
