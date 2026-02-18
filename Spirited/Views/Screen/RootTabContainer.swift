//
//  RootTabContainer.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/02/26.
//

import SwiftUI

struct RootTabContainer: View {

    @State private var selectedTab = 0
    @State private var filmsViewModel = FilmsViewModel()
    @State private var favouritesViewModel = FavouritesViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {

            TabView(selection: $selectedTab) {

                NavigationStack {
                    FilmsScreen(filmsViewModel: filmsViewModel, favouritesViewModel: favouritesViewModel)
                }
                .tag(0)

                NavigationStack {
                    FavouritesScreen(filmsViewModel: filmsViewModel, favouritesViewModel: favouritesViewModel)
                }
                .tag(1)

                NavigationStack {
                    SettingsScreen()
                }
                .tag(2)

                NavigationStack {
                    SearchScreen(favoritesViewModel: favouritesViewModel)
                }
                .tag(3)
//                .opacity(selectedTab == 3 ? 1 : 0)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .task {
                favouritesViewModel.load()
            }
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    RootTabContainer()
}
