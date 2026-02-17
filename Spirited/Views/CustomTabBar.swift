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

            // Gold gradient indicator at top
            GeometryReader { geo in
                Capsule()
                    .fill(LinearGradient.warmGold)
                    .frame(width: geo.size.width / 4 - 32, height: 3)
                    .shadow(color: Color.warmGoldMid.opacity(0.6), radius: 4, x: 0, y: 0)
                    .offset(x: CGFloat(selectedTab) * (geo.size.width / 4) + 16)
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
            .background(
                LinearGradient(
                    colors: [
                        Color.warmBackgroundTop,
                        Color.warmBackground
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .background(
            Color.warmBackgroundTop
                .shadow(color: Color.warmGoldMid.opacity(0.15), radius: 12, x: 0, y: -3)
        )
        .ignoresSafeArea(edges: .bottom)
    }

    private func select(_ index: Int) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selectedTab = index
        }
    }
}
