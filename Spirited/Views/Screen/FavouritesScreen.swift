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
       // TODO: get favorites
        // retrieve ids from storage
        // get data for favorite ids from films data
       
    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView(
                        "No Favorites yet",
                        systemImage: "heart"
                    )
                } else {
                    FilmListView(films: films,favouritesViewModel: favouritesViewModel)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavouritesScreen(
        filmsViewModel: FilmsViewModel(service: MockGhibliService()),
        favouritesViewModel: FavouritesViewModel(service: MockFavouriteStorage())
    )
}


