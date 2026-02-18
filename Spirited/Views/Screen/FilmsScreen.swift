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

            VStack(spacing: 0) {
                // Custom header title
                VStack(alignment: .leading, spacing: 4) {
                    Text("Studio Ghibli")
                        .font(.system(size: 34, weight: .bold, design: .serif))
                        .foregroundStyle(Color.warmGoldDeep)

                    Text("Explore Magical Ghibli Movies")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .tracking(1.5)
                        .foregroundStyle(Color.warmTextSoft.opacity(0.6))
                       
                    HStack{
                        Label {
                            Text("Director")
                                .font(.subheadline)
                                .foregroundStyle(Color.warmTextMid)
                        } icon: {
                            Image(systemName: "camera.aperture")
                                .font(.caption)
                                .foregroundStyle(Color.warmGoldDeep)
                        }
                        
                        Spacer()

                        Label {
                            Text("Release Date")
                                .font(.caption)
                                .foregroundStyle(Color.warmTextSoft.opacity(0.7))
                        } icon: {
                            Image(systemName: "calendar")
                                .font(.caption)
                                .foregroundStyle(Color.warmGoldDeep)
                        }
                    }
                    

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 16)

                // Content
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
                        .frame(maxHeight: .infinity)
                        
                    case .loading:
                        VStack(spacing: 16) {
                            ProgressView()
                                .scaleEffect(1.2)
                                .tint(Color.warmGoldDeep)
                            Text("Loading ...")
                                .font(.subheadline)
                                .foregroundStyle(Color.warmTextSoft.opacity(0.6))
                        }
                        .frame(maxHeight: .infinity)
                        
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
                        .frame(maxHeight: .infinity)
                    }
                }
            }
        }
        .navigationBarHidden(true)
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
