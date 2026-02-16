//
//  FavouritesScreen.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/02/26.
//

import SwiftUI

struct FavoritesScreen: View {

    let filmsViewModel: FilmsViewModel

    var films: [Film] {
        // TODO: get favorites
        // retrieve ids from storage
        // get data for favorite ids from films data
        return []
    }

    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView(
                        "No Favorites yet",
                        systemImage: "heart"
                    )
                } else {
                    FilmListView(films: films)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesScreen(
        filmsViewModel: FilmsViewModel(service: MockGhibliService())
    )
}

