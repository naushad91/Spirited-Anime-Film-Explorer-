//
//  FilmsScreen.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/02/26.
//

import SwiftUI

struct FilmsScreen: View {
    
    let filmsViewModel: FilmsViewModel
    let favouritesViewModel: FavouritesViewModel
        
    var body: some View {
        ZStack {
            LinearGradient.warmBackground
                .ignoresSafeArea()
            Group {
             
                switch filmsViewModel.state {
                    
                case .idle:
                    VStack(spacing: 16) {
                        Image(systemName: "film.stack")
                            .font(.system(size: 64))
                            .foregroundStyle(Color.warmGoldMid.opacity(0.6))
                        Text("No Films yet")
                            .font(.title3)
                            .foregroundStyle(Color.warmTextSoft.opacity(0.6))
                    }
                    
                case .loading:
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.2)
                            .tint(Color.warmGoldDeep)
                        Text("Loading ...")
                            .font(.subheadline)
                            .foregroundStyle(Color.warmTextSoft.opacity(0.6))
                    }
                    
                case .loaded(let films):
                    FilmListView(films: films, favouritesViewModel: favouritesViewModel)
                    
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
       
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.light, for: .navigationBar)
        .task {
            await filmsViewModel.fetch()
        }
    }
}


#Preview {
    NavigationStack {
        FilmsScreen(
            filmsViewModel: FilmsViewModel(service: MockGhibliService()),
            favouritesViewModel: FavouritesViewModel(service: MockFavouriteStorage())
        )
    }
}
