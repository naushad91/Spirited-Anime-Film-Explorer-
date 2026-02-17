//
//  FilmListView.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/01/26.
//

import SwiftUI

struct FilmListView: View {
    var films: [Film]
    let favouritesViewModel: FavouritesViewModel

    var body: some View {
        List(films) { film in
            NavigationLink(value: film) {
                FilmRow(film: film, favouritesViewModel: favouritesViewModel)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(LinearGradient.warmBackground)
        .navigationDestination(for: Film.self) { film in
            FilmDetailScreen(
                film: film,
                favouritesViewModel: favouritesViewModel
            )
        }
    }
}//#Preview {
//    @State @Previewable var vm =
//        FilmsViewModel(service: DefaultGhibliService())
//
//    FilmListView(filmsViewModel: vm)
//}
