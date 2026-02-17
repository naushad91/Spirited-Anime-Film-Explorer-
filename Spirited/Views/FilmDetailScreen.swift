//
//  FilmDetailScreen.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 13/02/26.
//

// MARK: - FilmDetailScreen
import SwiftUI

struct FilmDetailScreen: View {
    let film: Film
    let favouritesViewModel: FavouritesViewModel
    @State private var viewModel = FilmDetailViewModel()

    var body: some View {
        ZStack {
            LinearGradient.warmBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    // Banner image
                    FilmImageView(urlPath: film.bannerImage)
                        .frame(height: 300)
                        .containerRelativeFrame(.horizontal)
                        .overlay(
                            LinearGradient(
                                colors: [.clear, Color.warmBackgroundBot.opacity(0.95)],
                                startPoint: .center,
                                endPoint: .bottom
                            )
                        )

                    VStack(alignment: .leading, spacing: 12) {
                        Text(film.title)
                            .font(.system(size: 26, weight: .bold, design: .serif))
                            .foregroundStyle(Color.warmTextDark)

                        // Gold divider
                        Rectangle()
                            .fill(LinearGradient.warmGold)
                            .frame(height: 2)
                            .clipShape(Capsule())

                        switch viewModel.state {
                        case .idle:
                            EmptyView()

                        case .loading:
                            ProgressView()
                                .tint(Color.warmGoldMid)

                        case .loaded(let people):
                            ForEach(people) { person in
                                Text(person.name)
                                    .foregroundStyle(Color.warmTextMid)
                            }

                        case .error(let error):
                            Text(error)
                                .foregroundStyle(.pink)
                        }
                    }
                    .padding(20)
                }
            }
        }
        .toolbar {
            FavouriteButton(filmID: film.id, favouritesViewModel: favouritesViewModel)
        }
        .task {
            await viewModel.fetch(for: film)
        }
    }
}

#Preview {
    NavigationStack {
        FilmDetailScreen(film: Film.example,
                         favouritesViewModel: FavouritesViewModel(service: MockFavouriteStorage()))
    }
}
