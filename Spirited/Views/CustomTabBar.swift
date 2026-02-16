//
//  CustomTabBar.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/02/26.
//


import SwiftUI

struct CustomTabBar: View {

    @Binding var selectedTab: Int

    var body: some View {
        VStack(spacing: 0) {

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
                ) { select(0) }

                CustomTabButton(
                    icon: "heart",
                    title: "Favorites",
                    isSelected: selectedTab == 1
                ) { select(1) }

                CustomTabButton(
                    icon: "gear",
                    title: "Settings",
                    isSelected: selectedTab == 2
                ) { select(2) }

                CustomTabButton(
                    icon: "magnifyingglass",
                    title: "Search",
                    isSelected: selectedTab == 3
                ) { select(3) }
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

    private func select(_ index: Int) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selectedTab = index
        }
    }
}
