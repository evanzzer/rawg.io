//
//  ContentView.swift
//  Rawg.io
//
//  Created by Leafy on 07/06/22.
//

import SwiftUI
import Swinject

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    enum Tab: Int {
        case first, second
    }
    
    @State private var selectedTab = Tab.first
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if selectedTab == .first {
                    NavigationView {
                        VStack(spacing: 0) {
                            SearchView(presenter: SearchPresenter(
                                searchUseCase: Assembler.sharedAssembler.resolver.resolve(SearchUseCase.self)!
                            ))
                            tabBarView
                        }
                    }
                } else if selectedTab == .second {
                    NavigationView {
                        VStack(spacing: 0) {
                            FavoriteView(presenter: FavoritePresenter(
                                favoriteUseCase: Assembler.sharedAssembler.resolver.resolve(FavoriteUseCase.self)!
                            ))
                            tabBarView
                        }
                    }
                }
            }
        }
    }
    
    var tabBarView: some View {
        VStack(spacing: 0) {
            Divider()
            
            HStack {
                Spacer()
                tabBarItem(.first, title: "Search", icon: "magnifyingglass", selectedIcon: "magnifyingglass")
                Spacer()
                tabBarItem(.second, title: "Favorite", icon: "star", selectedIcon: "star.fill")
                Spacer()
            }
            .padding(.top, 8)
        }
        .frame(height: 50)
        .background((colorScheme == .dark ? Color.black : Color.white).edgesIgnoringSafeArea(.all))
    }
    
    func tabBarItem(_ tab: Tab, title: String, icon: String, selectedIcon: String) -> some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 3) {
                VStack {
                    Image(systemName: (selectedTab == tab ? selectedIcon : icon))
                        .foregroundColor(selectedTab == tab
                                         ? .blue
                                         : (colorScheme == .dark ? Color.white : Color.black))
                        .font(.system(size: 24))
                }
                .frame(width: 55, height: 28)
                
                Text(title)
                    .font(.system(size: 11))
                    .foregroundColor(selectedTab == tab ? .blue : (colorScheme == .dark ? Color.white : Color.black))
            }
        }
        .frame(width: 65, height: 42)
        .onTapGesture {
            selectedTab = tab
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
