//
//  FilmListView.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/01/26.
//

import SwiftUI

struct FilmListView: View {
    
    // films: [Film]
    
//    @State private var filmsViewModel = FilmsViewModel() Not good here, need Dependency Injection
    var filmsViewModel = FilmsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Soft background gradient
                LinearGradient(
                    colors: [Color(.systemBackground), Color(.systemGray6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                switch filmsViewModel.state {
                    
                case .idle:
                    VStack(spacing: 16) {
                        Image(systemName: "film.stack")
                            .font(.system(size: 64))
                            .foregroundStyle(.secondary)
                        Text("No Films yet")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }
                    
                case .loading:
                    VStack(spacing: 20) {
                        ProgressView()
                            .scaleEffect(1.2)
                        Text("Loading ...")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                case .loaded(let films):
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
                    
                case .error(let error):
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.pink)
                        Text(error)
                            .font(.subheadline)
                            .foregroundStyle(.pink)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                }
            }
            .navigationTitle("Studio Ghibli")
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            await filmsViewModel.fetch()
        }
    }
}

#Preview {
    @State @Previewable var vm =
        FilmsViewModel(service: DefaultGhibliService())

    FilmListView(filmsViewModel: vm)
}
