//
//  FilmImageView.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 15/02/26.
//

import SwiftUI

struct FilmImageView: View {

    let urlPath: String

    var body: some View {
        AsyncImage(url: URL(string: urlPath)) { phase in
            switch phase {
            case .empty:
                Color.gray

            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()

            case .failure(_):
                Text("Could not get image")

            @unknown default:
                fatalError()
            }
        }
            }
}

#Preview("poster image") {
    FilmImageView(urlPath: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg"
    )
    .frame(height: 150)
}

#Preview("banner image") {
    FilmImageView(
        urlPath: "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg"
    )
    .frame(height: 300)
}
