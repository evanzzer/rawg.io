//
//  FavoriteList.swift
//  Rawg.io
//
//  Created by Leafy on 10/06/22.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter
    
    var body: some View {
        VStack {
            if presenter.loadingState {
                ProgressView().progressViewStyle(.circular)
            } else {
                if presenter.list.count > 0 {
                    List(presenter.list) { game in
                        ZStack(alignment: .leading) {
                            GameRow(game: game)
                            presenter.linkBuilder(for: game.id, content: { EmptyView() })
                        }
                        .listRowSeparator(.hidden)
                    }
                } else {
                    Text("You still have empty favorite list!")
                        .font(.system(size: 18))
                        .bold()
                    Text("Go find a game in the Search Tab!")
                }
            }
        }.navigationTitle("Favorite")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(.blue)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .onAppear {
                presenter.retrieveData()
            }
    }
}
