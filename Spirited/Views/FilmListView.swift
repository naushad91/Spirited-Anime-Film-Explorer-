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
        NavigationStack {
            switch filmsViewModel.state {
                
            case .idle:
                Text("No Films yet")
                
            case .loading:
                ProgressView {
                    Text("Loading ...")
                }
                
            case .loaded(let films):
                List(films) {
                    Text($0.title)
                }
                
            case .error(let error):
                Text(error)
                    .foregroundStyle(.pink)
            }
        }
        .task {
            await filmsViewModel.fetch()
        }
    }
       
}

#Preview {
    FilmListView()
}
