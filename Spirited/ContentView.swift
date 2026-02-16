//
//  ContentView.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 14/01/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // MARK: — Main Screens Connected Here
            TabView(selection: $selectedTab) {
                
                NavigationStack {
                    FilmsScreen()
                }
                .tag(0)
                
                NavigationStack {
                    FavouritesScreen()
                }
                .tag(1)
                
                NavigationStack {
                    SettingsScreen()
                }
                .tag(2)
                
                
                SearchScreen().tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            
            // MARK: — Custom Tab Bar
            VStack(spacing: 0) {
                
                // Top indicator bar
                GeometryReader { geo in
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: geo.size.width / 4, height: 3)
                        .offset(x: CGFloat(selectedTab) * (geo.size.width / 4))
                }
                .frame(height: 3)
                
                HStack(spacing: 0) {
                    
                    CustomTabButton(
                        icon: "movieclapper",
                        title: "Movies",
                        isSelected: selectedTab == 0
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = 0
                        }
                    }
                    
                    CustomTabButton(
                        icon: "heart",
                        title: "Favorites",
                        isSelected: selectedTab == 1
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = 1
                        }
                    }
                    
                    CustomTabButton(
                        icon: "gear",
                        title: "Settings",
                        isSelected: selectedTab == 2
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = 2
                        }
                    }
                    
                    CustomTabButton(
                        icon: "magnifyingglass",
                        title: "Search",
                        isSelected: selectedTab == 3
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = 3
                        }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
                .background(Color.white)
            }
            .background(
                Color.white
                    .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: -2)
            )
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    ContentView()
}
