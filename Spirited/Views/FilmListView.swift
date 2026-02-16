//
//  FilmListView.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/01/26.
//

import SwiftUI

struct FilmListView: View {
    
    var films: [Film]
    
//    @State private var filmsViewModel = FilmsViewModel() Not good here, need Dependency Injection
    var filmsViewModel = FilmsViewModel()
    
    var body: some View {
      
            
                    List(films) { film in
                        NavigationLink(value: film) {
                            HStack(spacing: 16) {
                                FilmImageView(urlPath: film.image)
                                    .frame(width: 120, height: 160)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                                
                                Text(film.title)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                    .lineLimit(2)
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(Color(.systemBackground))
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .navigationDestination(for: Film.self) { film in
                        FilmDetailScreen(film: film)
                    }
                    
    }
}

//#Preview {
//    @State @Previewable var vm =
//        FilmsViewModel(service: DefaultGhibliService())
//
//    FilmListView(filmsViewModel: vm)
//}
