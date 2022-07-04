//
//  GameRow.swift
//  Rawg.io
//
//  Created by Leafy on 07/06/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameRow: View {
    var game: GamesModel
    
    var body: some View {
        HStack {
            
            if let image = game.imageUrl {
                WebImage(url: URL(string: image))
                    .resizable()
                    .placeholder {
                        Image(systemName: "photo")
                            .frame(alignment: .center)
                            .padding(EdgeInsets(top: 6, leading: 0, bottom: 0, trailing: 0))
                    }
                    .transition(.fade(duration: 0.5))
                    .cornerRadius(5)
                    .frame(width: 128, height: 72, alignment: .center)
            } else {
                Image(systemName: "photo")
                    .frame(width: 128, height: 72, alignment: .center)
            }
            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.system(size: 20))
                    .bold()
                Text(game.released != nil ? "Released on \(game.released!)" : "Unknown Release Date")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                Text(game.rating > 0 ? "Rating: \(String(format: "%.2f", game.rating)) \u{2605}" : "No Ratings so far")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }.padding(.leading, 6)
            Spacer()
        }
    }
}

struct Previews_GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: GamesModel(
            id: 1,
            name: "Game",
            released: "2022-05-01",
            // swiftlint:disable line_length
            imageUrl: "https://media.istockphoto.com/photos/abstract-wavy-object-picture-id1198271727?b=1&k=20&m=1198271727&s=170667a&w=0&h=b626WM5c-lq9g_yGyD0vgufb4LQRX9UgYNWPaNUVses=",
            rating: 5
        )).previewLayout(.fixed(width: 400, height: 150))
    }
}
