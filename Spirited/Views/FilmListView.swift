//
//  FilmListView.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/01/26.
//

import SwiftUI

struct FilmListView: View {
    
    // films: [Film]
    
    @State private var filmsViewModel = FilmsViewModel()
    
    var body: some View {
                List(filmsViewModel.films) {
            Text($0.title)
        }
        .task {
            await filmsViewModel.fetchFilms()
        }
    }
}

#Preview {
    FilmListView()
}
