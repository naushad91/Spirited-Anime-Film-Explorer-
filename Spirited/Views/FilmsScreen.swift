//
//  FilmsScreen.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/02/26.
//

import SwiftUI

struct FilmsScreen: View {
    
    let filmsViewModel : FilmsViewModel
        
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
                    Group{
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
                            FilmListView(films: films )
                            
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
    FilmsScreen(filmsViewModel: FilmsViewModel(service: MockGhibliService()))
}

