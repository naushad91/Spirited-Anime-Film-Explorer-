//
//  FilmDetailScreen.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 13/02/26.
//

import SwiftUI

struct FilmDetailScreen: View {

    let film: Film
    @State private var viewModel = FilmDetailViewModel()

    var body: some View {
        
        VStack{
            
            AsyncImage(url: URL(string: film.bannerImage)) { phase in
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
            .frame(height: 200)

            
            Text(film.title)
            
            Divider()
            
            switch viewModel.state {
               

            case .idle:
                EmptyView()

            case .loading:
                ProgressView()

            case .loaded(let people):
                ForEach(people) { person in
                    Text(person.name)
                }

            case .error(let error):
                Text(error)
                    .foregroundStyle(.pink)
            }
        }
        .task {
            await viewModel.fetch(for: film)
        }

            
        }
    
}

#Preview {
    FilmDetailScreen(film: Film.example)
}
