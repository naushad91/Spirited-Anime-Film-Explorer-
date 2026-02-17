//
//  FilmRow.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/02/26.
//


// MARK: - FilmRow
import SwiftUI

struct FilmRow: View {
    let film: Film
    let favouritesViewModel: FavouritesViewModel

    private var isFavourite: Bool {
        favouritesViewModel.isFavourite(filmID: film.id)
    }

    var body: some View {
        HStack(spacing: 16) {
            FilmImageView(urlPath: film.image)
                .frame(width: 100, height: 145)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(LinearGradient.warmGold, lineWidth: 2)
                )
                .shadow(color: Color.warmGoldMid.opacity(0.3), radius: 8, x: 0, y: 4)

            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Text(film.title)
                        .font(.system(size: 16, weight: .bold, design: .serif))
                        .foregroundStyle(Color.warmTextDark)
                        .lineLimit(2)

                    Spacer()

                    FavouriteButton(filmID: film.id, favouritesViewModel: favouritesViewModel)
                        .buttonStyle(.plain)
                        .controlSize(.large)
                }

                // Gold divider line
                Rectangle()
                    .fill(LinearGradient.warmGold)
                    .frame(height: 1)
                    .opacity(0.5)

                VStack(alignment: .leading, spacing: 4) {
                    Label {
                        Text(film.director)
                            .font(.subheadline)
                            .foregroundStyle(Color.warmTextMid)
                    } icon: {
                        Image(systemName: "camera.aperture")
                            .font(.caption)
                            .foregroundStyle(Color.warmGoldDeep)
                    }

                    Label {
                        Text(film.releaseYear)
                            .font(.caption)
                            .foregroundStyle(Color.warmTextSoft.opacity(0.7))
                    } icon: {
                        Image(systemName: "calendar")
                            .font(.caption)
                            .foregroundStyle(Color.warmGoldDeep)
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.warmBackgroundTop)
                .shadow(color: Color.warmGoldMid.opacity(0.2), radius: 8, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.warmGoldBright.opacity(0.6),
                            Color.warmGoldMid.opacity(0.2)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
    }
}
