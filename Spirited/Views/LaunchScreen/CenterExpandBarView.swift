//
//  CenterExpandBarView.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/02/26.
//



import SwiftUI

struct CenterExpandBarView: View {
    @State private var expanded = false
    @State private var shimmer = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Base bar
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 255/255, green: 200/255, blue: 60/255),
                                Color(red: 255/255, green: 160/255, blue: 30/255),
                                Color(red: 240/255, green: 120/255, blue: 10/255)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(
                        width: expanded ? geo.size.width * 0.72 : 8,
                        height: 4.5
                    )
                    .shadow(color: Color(red: 255/255, green: 160/255, blue: 30/255).opacity(0.7), radius: 10)

                // Shimmer overlay
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0),
                                Color.white.opacity(0.5),
                                Color.white.opacity(0)
                            ],
                            startPoint: shimmer ? .leading : .trailing,
                            endPoint: shimmer ? .trailing : .leading
                        )
                    )
                    .frame(
                        width: expanded ? geo.size.width * 0.72 : 8,
                        height: 4.5
                    )
                    .animation(
                        .easeInOut(duration: 1.6)
                        .repeatForever(autoreverses: false)
                        .delay(1.2),
                        value: shimmer
                    )
            }
            // Edge fade mask
            .mask(
                LinearGradient(
                    stops: [
                        .init(color: .clear, location: 0),
                        .init(color: .white, location: 0.12),
                        .init(color: .white, location: 0.88),
                        .init(color: .clear, location: 1)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .animation(.easeOut(duration: 1.1), value: expanded)
        }
        .frame(height: 24)
        .onAppear {
            expanded = true
            shimmer = true
        }
    }
}

#Preview {
    CenterExpandBarView()
}