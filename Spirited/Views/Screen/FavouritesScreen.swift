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

            VStack(spacing: 0) {
                // Custom header title
                VStack(alignment: .leading, spacing: 4) {
                    Text("Favourites")
                        .font(.system(size: 34, weight: .bold, design: .serif))
                        .foregroundStyle(Color.warmGoldDeep)

                    Text("Save your Favourite Movies")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .tracking(1.5)
                        .foregroundStyle(Color.warmTextSoft.opacity(0.6))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 16)

                // Content
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
                    .frame(maxHeight: .infinity)
                    .offset(y: -80)
                } else {
                    FilmListView(films: films, favouritesViewModel: favouritesViewModel)
                }
            }
        }
        .navigationBarHidden(true)
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
