//
//  RootTabContainer.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/02/26.
//

import SwiftUI

struct RootTabContainer: View {

    @State private var selectedTab = 0

    var body: some View {
        ZStack(alignment: .bottom) {

            TabView(selection: $selectedTab) {

                NavigationStack {
                    FilmListView()
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

               
              SearchScreen()
                
                .tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    RootTabContainer()
}
