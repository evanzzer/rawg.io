//
//  GameList.swift
//  Rawg.io
//
//  Created by Leafy on 07/06/22.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var presenter: SearchPresenter
    
    private let router = SearchRouter()
    
    var body: some View {
        VStack {
            if presenter.isLoading {
                ProgressView().progressViewStyle(.circular)
            } else {
                if presenter.isError {
                    Text(presenter.errorMessage)
                } else if presenter.list.count == 0 {
                    Text("No data has been found!")
                } else {
                    List(self.presenter.list) { game in
                        ZStack(alignment: .leading) {
                            GameRow(game: game)
                            NavigationLink(destination: router.makeDetailView(for: game.id)) {
                                EmptyView()
                            }.opacity(0.0)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
            }
        }.navigationTitle("rawg.io")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(.blue)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .searchable(text: $presenter.query, placement: .navigationBarDrawer(displayMode: .automatic))
    }
}
