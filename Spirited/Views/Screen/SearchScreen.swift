//
//  SearchScreen.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/02/26.
//

import SwiftUI

struct SearchScreen: View {

    @State private var text: String = ""
    @State private var searchViewModel: SearchFilmsViewModel
    let favoritesViewModel: FavouritesViewModel

    init(
        favoritesViewModel: FavouritesViewModel,
        service: GhibliService = DefaultGhibliService()
    ) {
        self.favoritesViewModel = favoritesViewModel
        self._searchViewModel = State(
            initialValue: SearchFilmsViewModel(service: service)
        )
    }

    var body: some View {
        ZStack {
            LinearGradient.warmBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Custom header title
                VStack(alignment: .leading, spacing: 4) {
                    Text("Search")
                        .font(.system(size: 34, weight: .bold, design: .serif))
                        .foregroundStyle(Color.warmGoldDeep)

                    Text("Explore the Ghibliverse")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .tracking(1.5)
                        .foregroundStyle(Color.warmTextSoft.opacity(0.6))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 12)

                // Custom search bar
                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.warmGoldMid.opacity(0.7))
                        .font(.system(size: 16))
                    
                    TextField("Search Ghibli films...", text: $text)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.warmTextDark)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled()
                    
                    if !text.isEmpty {
                        Button {
                            text = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(Color.warmTextSoft.opacity(0.5))
                                .font(.system(size: 16))
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.warmBackgroundTop)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    LinearGradient(
                                        colors: [
                                            Color.warmGoldBright.opacity(0.4),
                                            Color.warmGoldMid.opacity(0.2)
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    lineWidth: 1.5
                                )
                        )
                        .shadow(color: Color.warmGoldMid.opacity(0.15), radius: 6, x: 0, y: 2)
                )
                .padding(.horizontal, 16)
                .padding(.bottom, 16)

                // Search results
                switch searchViewModel.state {

                case .idle:
                    VStack(spacing: 16) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 64))
                            .foregroundStyle(Color.warmGoldMid.opacity(0.6))
                        
                        Text("Search Ghibli Films")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                            .foregroundStyle(Color.warmTextDark)
                        
                        Text("Start typing to find your favorites")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .tracking(0.8)
                            .foregroundStyle(Color.warmTextSoft.opacity(0.6))
                    }
                    .frame(maxHeight: .infinity)
                    .offset(y: -80)

                case .loading:
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.2)
                            .tint(Color.warmGoldDeep)
                        Text("Searching...")
                            .font(.subheadline)
                            .foregroundStyle(Color.warmTextSoft.opacity(0.6))
                    }
                    .frame(maxHeight: .infinity)
                    .offset(y: -80)

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
                    .offset(y: -80)

                case .loaded(let films):
                    if films.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "film.stack")
                                .font(.system(size: 64))
                                .foregroundStyle(Color.warmGoldMid.opacity(0.6))
                            Text("No films found")
                                .font(.system(size: 20, weight: .bold, design: .serif))
                                .foregroundStyle(Color.warmTextDark)

                                
                            Text("Try a different search")
                                .font(.caption)
                                .foregroundStyle(Color.warmTextSoft.opacity(0.6))
                        }
                        .frame(maxHeight: .infinity)
                        .offset(y: -80)
                    } else {
                        FilmListView(
                            films: films,
                            favouritesViewModel: favoritesViewModel
                        )
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .task(id: text) {
            try? await Task.sleep(for: .milliseconds(500))
            guard !Task.isCancelled else { return }
            await searchViewModel.fetch(with: text)
        }
    }
}
