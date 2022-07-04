//
//  GameDetail.swift
//  Rawg.io
//
//  Created by Leafy on 07/06/22.
//

import SwiftUI
import Swinject
import SDWebImageSwiftUI

private struct AlertInfo: Identifiable {
    enum AlertCode {
        case fav
        case unfav
        case error
    }
    
    let id: AlertCode
    let title: String
    let message: String
    let button: String
}

struct DetailView: View {
    var id: Int
    @ObservedObject var presenter: DetailPresenter
    
    @State private var alertInfo: AlertInfo?
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                ProgressView().progressViewStyle(.circular)
            } else {
                if !presenter.errorMessage.isEmpty {
                    Text(presenter.errorMessage)
                } else {
                    if let data = presenter.data {
                        ScrollView {
                            VStack {
                                VStack(alignment: .center) {
                                    Text(data.name)
                                        .font(.title)
                                        .bold()
                                    if !data.alternativeNames.isEmpty {
                                        Text("Also known as \(data.alternativeNames.joined(separator: ", "))")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                    }
                                }

                                if let image = data.imageUrl {
                                    WebImage(url: URL(string: image))
                                        .resizable()
                                        .placeholder {
                                            Image(systemName: "photo")
                                                .frame(alignment: .center)
                                                .padding(EdgeInsets(top: 6, leading: 0, bottom: 0, trailing: 0))
                                        }
                                        .transition(.fade(duration: 0.5))
                                        .scaledToFit()
                                        .cornerRadius(15)
                                } else {
                                    Image(systemName: "photo")
                                        .frame(height: 72, alignment: .center)
                                }
                                
                                content
                                Spacer()
                            }.padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                        }
                    } else {
                        Text("Unknown error has occurred.")
                    }
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
            .onAppear {
                presenter.retrieveData(id: id)
                presenter.retrieveFavoriteStatus(id: id)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: presenter.isFavorited ? "star.fill" : "star")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            if !presenter.loadingState {
                                if let data = presenter.data {
                                    if presenter.isFavorited {
                                        presenter.deleteFromFavoriteList(id: id) {
                                            self.alertInfo = AlertInfo(
                                                id: .unfav,
                                                title: "Information",
                                                message: "\(data.name) has been removed to Favorite List",
                                                button: "OK"
                                            )
                                        }
                                    } else {
                                        presenter.insertToFavoriteList(
                                            id: id,
                                            name: data.name,
                                            released: data.released,
                                            imageUrl: data.imageUrl,
                                            rating: data.rating
                                        ) {
                                            self.alertInfo = AlertInfo(
                                                id: .fav,
                                                title: "Information",
                                                message: "\(data.name) has been added to Favorite List",
                                                button: "OK"
                                            )
                                        }
                                    }
                                } else {
                                    self.alertInfo = AlertInfo(
                                        id: .error,
                                        title: "Error",
                                        message: "Unknown Error has occurred.",
                                        button: "Alright"
                                    )
                                }
                                
                            } else {
                                self.alertInfo = AlertInfo(
                                    id: .error,
                                    title: "Error",
                                    message: "Data has not ready yet. Please be patient!",
                                    button: "Alright"
                                )
                            }
                        }
                }
            }
            .alert(item: $alertInfo) { info in
                Alert(title: Text(info.title),
                      message: Text(info.message),
                      dismissButton: .default(Text(info.button)))
            }
    }
}

extension DetailView {
    
    var content: some View {
        let data = presenter.data!
        return HStack {
            VStack(alignment: .leading) {
                Spacer(minLength: 16)
                Text(data.description)
                Spacer(minLength: 24)
                Text("More Information")
                    .font(.system(size: 24))
                    .bold()
                Group {
                    Spacer(minLength: 4)
                    Text("Released")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.gray)
                    Text(data.released)
                }
                Group {
                    Spacer(minLength: 4)
                    Text("Website")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.gray)
                    Text(data.website)
                }
                Group {
                    Spacer(minLength: 4)
                    Text("Rating")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.gray)
                    Text(data.rating > 0 ? "\(String(format: "%.2f", data.rating)) \u{2605}" : "No Ratings")
                }
                Group {
                    Spacer(minLength: 4)
                    Text("Platforms")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.gray)
                    Text(data.platforms)
                }
                Group {
                    Spacer(minLength: 4)
                    Text("Genres")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.gray)
                    Text(data.genres)
                }
                Group {
                    Spacer(minLength: 4)
                    Text("Publishers")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.gray)
                    Text(data.publishers)
                }
            }
        }
    }
}

struct Previews_GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: 3498, presenter: DetailPresenter(
            detailUseCase: Assembler.sharedAssembler.resolver.resolve(DetailUseCase.self)!
        ))
    }
}
