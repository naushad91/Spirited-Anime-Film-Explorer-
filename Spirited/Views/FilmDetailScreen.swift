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
    @State private var isDescriptionExpanded = false
    
    var body: some View {
        ZStack {
            LinearGradient.warmBackground
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Banner image with gradient overlay
                    ZStack(alignment: .bottom) {
                        FilmImageView(urlPath: film.bannerImage)
                            .frame(height: 300)
                            .containerRelativeFrame(.horizontal)
                            .clipped()
                        
                        // Gradient fade to background
                        LinearGradient(
                            colors: [
                                Color.clear,
                                Color.warmBackgroundBot.opacity(0.8),
                                Color.warmBackgroundBot
                            ],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        .frame(height: 120)
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Title
                        Text(film.title)
                            .font(.system(size: 28, weight: .bold, design: .serif))
                            .foregroundStyle(Color.warmTextDark)
                        
                        // Info grid with icons
                        VStack(spacing: 12) {
                            InfoRow(
                                icon: "person.circle",
                                label: "Director",
                                value: film.director
                            )
                            InfoRow(
                                icon: "person.2",
                                label: "Producer",
                                value: film.producer
                            )
                            InfoRow(
                                icon: "calendar",
                                label: "Release Date",
                                value: film.releaseYear
                            )
                            InfoRow(
                                icon: "clock",
                                label: "Running Time",
                                value: "\(film.duration) min"
                            )
                            InfoRow(
                                icon: "star.fill",
                                label: "Score",
                                value: "\(film.score)/100"
                            )
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.warmBackgroundTop)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(
                                            LinearGradient(
                                                colors: [
                                                    Color.warmGoldBright.opacity(0.5),
                                                    Color.warmGoldMid.opacity(0.2)
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 1
                                        )
                                )
                                .shadow(color: Color.warmGoldMid.opacity(0.15), radius: 8, x: 0, y: 3)
                        )
                        
                        // Gold divider
                        Rectangle()
                            .fill(LinearGradient.warmGold)
                            .frame(height: 2)
                            .clipShape(Capsule())
                            .padding(.vertical, 8)
                        
                        // Description - Expandable
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Description")
                                    .font(.system(size: 20, weight: .bold, design: .serif))
                                    .foregroundStyle(Color.warmGoldDeep)
                                
                                Spacer()
                                
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        isDescriptionExpanded.toggle()
                                    }
                                } label: {
                                    Image(systemName: isDescriptionExpanded ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundStyle(Color.warmGoldDeep)
                                }
                            }
                            
                            Text(film.description)
                                .font(.body)
                                .foregroundStyle(Color.warmTextMid)
                                .lineSpacing(4)
                                .lineLimit(isDescriptionExpanded ? nil : 3)
                        }
                        
                        // Gold divider
                        Rectangle()
                            .fill(LinearGradient.warmGold)
                            .frame(height: 2)
                            .clipShape(Capsule())
                            .padding(.vertical, 8)
                        
                        // Characters section
                        CharacterSectionView(viewModel: viewModel)
                    }
                    .padding(20)
                }
            }
            .scrollIndicators(.hidden)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.warmBackgroundTop.opacity(0.95), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(film.title)
                    .font(.headline)
                    .foregroundStyle(Color.warmGoldDeep)
                    .lineLimit(1)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                FavouriteButton(
                    filmID: film.id,
                    favouritesViewModel: favouritesViewModel
                )
            }
        }
        .task(id: film) {
            await viewModel.fetch(for: film)
        }
    }
}

fileprivate struct InfoRow: View {
    
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(Color.warmGoldDeep)
                .frame(width: 28, alignment: .center)
            
            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.warmTextMid)
                .frame(width: 120, alignment: .leading)
            
            Text(value)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(Color.warmTextDark)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

fileprivate struct CharacterSectionView: View {
    
    let viewModel: FilmDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Characters")
                .font(.system(size: 20, weight: .bold, design: .serif))
                .foregroundStyle(Color.warmGoldDeep)
            
            switch viewModel.state {
            case .idle:
                EmptyView()
                
            case .loading:
                HStack {
                    Spacer()
                    ProgressView()
                        .tint(Color.warmGoldDeep)
                    Spacer()
                }
                .padding()
                
            case .loaded(let people):
                VStack(spacing: 12) {
                    ForEach(people) { person in
                        PersonRow(person: person)
                    }
                }
                
            case .error(let error):
                Text(error)
                    .foregroundStyle(.pink)
                    .font(.subheadline)
                    .padding()
            }
        }
    }
}

fileprivate struct PersonRow: View {
    let person: Person
    
    private var genderText: String {
        person.gender?.isEmpty == false ? person.gender! : "NA"
    }
    
    private var ageText: String {
        person.age?.isEmpty == false ? person.age! : "NA"
    }
    
    private var eyeColorText: String {
        person.eyeColor?.isEmpty == false ? person.eyeColor! : "NA"
    }
    
    private var hairColorText: String {
        person.hairColor?.isEmpty == false ? person.hairColor! : "NA"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(person.name)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color.warmTextDark)
            
            // Use Grid for perfect alignment
            Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 6) {
                GridRow {
                    HStack(spacing: 6) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.warmGoldDeep)
                            .frame(width: 16)
                        Text(genderText)
                            .font(.system(size: 13))
                    }
                    
                    HStack(spacing: 6) {
                        Image(systemName: "calendar")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.warmGoldDeep)
                            .frame(width: 16)
                        Text(ageText)
                            .font(.system(size: 13))
                    }
                }
                
                GridRow {
                    HStack(spacing: 6) {
                        Image(systemName: "eye")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.warmGoldDeep)
                            .frame(width: 16)
                        Text(eyeColorText)
                            .font(.system(size: 13))
                    }
                    
                    HStack(spacing: 6) {
                        Image(systemName: "scissors")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.warmGoldDeep)
                            .frame(width: 16)
                        Text(hairColorText)
                            .font(.system(size: 13))
                    }
                }
            }
            .foregroundStyle(Color.warmTextSoft.opacity(0.8))
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.warmBackgroundTop)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.warmGoldMid.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

#Preview {
    NavigationStack {
        FilmDetailScreen(
            film: Film.example,
            favouritesViewModel: FavouritesViewModel(service: MockFavouriteStorage())
        )
    }
}
