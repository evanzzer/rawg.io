//
//  Rawg_ioApp.swift
//  Rawg.io
//
//  Created by Leafy on 07/06/22.
//

import SwiftUI

@main
struct Rawg_ioApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SearchPresenter(useCase: GamesInjection.init().provideGames()))
                .environmentObject(FavoritePresenter(useCase: FavoriteInjection.init().provideFavorite()))
        }
    }
}
