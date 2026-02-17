//
//  FilmRow.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/02/26.
//


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
                .frame(width: 120, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 6) {
                
                HStack {
                    Text(film.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    FavouriteButton(filmID: film.id, favouritesViewModel: favouritesViewModel)
                    .buttonStyle(.plain)
                    .controlSize(.large)
                }
                .padding(.bottom, 4)
                
                Text("Directed by \(film.director)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Released: \(film.releaseYear)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        
        .padding(.vertical, 8)
    }
}
