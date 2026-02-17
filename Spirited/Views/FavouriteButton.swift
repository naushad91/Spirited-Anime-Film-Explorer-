//
//  FavouriteButton.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/02/26.
//


// MARK: - FavouriteButton
import SwiftUI

struct FavouriteButton: View {
    let filmID: String
    let favouritesViewModel: FavouritesViewModel

    var isFavourite: Bool {
        favouritesViewModel.isFavourite(filmID: filmID)
    }

    var body: some View {
        Button {
            favouritesViewModel.toggleFavourite(filmID: filmID)
        } label: {
            Image(systemName: isFavourite ? "heart.fill" : "heart")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(isFavourite ? Color.warmGoldDeep : Color.warmTextSoft.opacity(0.5))
                .scaleEffect(isFavourite ? 1.15 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isFavourite)
        }
    }
}
