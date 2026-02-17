//
//  FilmListView.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/01/26.
//

import SwiftUI

struct FilmListView: View {
    
    
    
//    @State private var filmsViewModel = FilmsViewModel() Not good here, need Dependency Injection
//    var filmsViewModel = FilmsViewModel()
    var films: [Film]
    let favouritesViewModel: FavouritesViewModel
    var body: some View {
      
            
                    List(films) { film in
                        NavigationLink(value: film) {
                            FilmRow(film: film, favouritesViewModel: favouritesViewModel)
                        }
                        .listRowBackground(Color(.systemBackground))
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .navigationDestination(for: Film.self) { film in
                        FilmDetailScreen(film: film, favouritesViewModel: favouritesViewModel)
                    }
                 
                    
    }
}

//#Preview {
//    @State @Previewable var vm =
//        FilmsViewModel(service: DefaultGhibliService())
//
//    FilmListView(filmsViewModel: vm)
//}
