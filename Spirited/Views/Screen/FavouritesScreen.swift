//
//  FavouritesScreen.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/02/26.
//

import SwiftUI

struct FavouritesScreen: View {

    let filmsViewModel: FilmsViewModel
    let favouritesViewModel: FavouritesViewModel

    var films: [Film] {
        let favorites = favouritesViewModel.favouriteIDs
        switch filmsViewModel.state {
        case .loaded(let films):
            return films.filter { favorites.contains($0.id) }
        default: return []
        }
    }

    var body: some View {
        ZStack {
            LinearGradient.warmBackground
                .ignoresSafeArea()

            Group {
                if films.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "heart")
                            .font(.system(size: 64))
                            .foregroundStyle(Color.warmGoldMid.opacity(0.6))

                        Text("No Favorites Yet")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                            .foregroundStyle(Color.warmTextDark)

                        Text("Films you love will appear here")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .tracking(0.8)
                            .foregroundStyle(Color.warmTextSoft.opacity(0.6))
                    }
                    .offset(y: -60)
                } else {
                    FilmListView(films: films, favouritesViewModel: favouritesViewModel)
                }
            }
        }
        .navigationTitle("Favourites")
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(Color.warmBackgroundTop, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = UIColor(Color.warmBackgroundTop)
            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor(Color.warmGoldDeep),
                .font: UIFont.systemFont(ofSize: 34, weight: .bold)
            ]
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor(Color.warmGoldDeep)
            ]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    NavigationStack {
        FavouritesScreen(
            filmsViewModel: FilmsViewModel(service: MockGhibliService()),
            favouritesViewModel: FavouritesViewModel(service: MockFavouriteStorage())
        )
    }
}
