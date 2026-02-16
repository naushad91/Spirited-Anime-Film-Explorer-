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
            
            FilmImageView(urlPath: film.bannerImage)
                              .frame(height: 300)
                              .containerRelativeFrame(.horizontal)
            
            VStack(alignment: .leading){
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
        }
        .padding(20)
        .task {
            await viewModel.fetch(for: film)
        }

            
        }
    
}

#Preview {
    FilmDetailScreen(film: Film.example)
}
