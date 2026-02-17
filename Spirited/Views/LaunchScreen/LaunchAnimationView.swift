//
//  LaunchAnimationView.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/02/26.
//

import SwiftUI

struct LaunchAnimationView: View {
    @State private var logoVisible = false
    @State private var taglineVisible = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 255/255, green: 255/255, blue: 250/255),
                    Color(red: 255/255, green: 253/255, blue: 230/255),
                    Color(red: 255/255, green: 249/255, blue: 210/255)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            GeometryReader { outerGeo in
                VStack(spacing: 0) {
                    Spacer()

                    // Logo image with golden border
                    GeometryReader { geo in
                        Image("Spirited")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width * 0.8, height: geo.size.width * 0.62)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(
                                        LinearGradient(
                                            colors: [
                                                Color(red: 255/255, green: 200/255, blue: 60/255),
                                                Color(red: 255/255, green: 160/255, blue: 30/255),
                                                Color(red: 240/255, green: 120/255, blue: 10/255)
                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ),
                                        lineWidth: 3
                                    )
                            )
                            .shadow(
                                color: Color(red: 255/255, green: 160/255, blue: 30/255).opacity(0.35),
                                radius: 14, x: 0, y: 4
                            )
                            .frame(maxWidth: .infinity)
                            .position(x: geo.size.width / 2, y: geo.size.height / 2)
                    }
                    // Use the available width from context to determine height (no UIScreen.main)
                    .frame(height: outerGeo.size.width * 0.62)
                    .opacity(logoVisible ? 1 : 0)
                    .scaleEffect(logoVisible ? 1 : 0.88)
                    .animation(.spring(response: 0.9, dampingFraction: 0.7), value: logoVisible)

                    Spacer().frame(height: 28)

                    // Tagline
                    VStack(spacing: 6) {
                        Text("Spirited")
                            .font(.system(size: 34, weight: .bold, design: .serif))
                            .foregroundStyle(Color(red: 40/255, green: 25/255, blue: 5/255))

                        Text("Explore the Ghibli Universe")
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(red: 60/255, green: 40/255, blue: 10/255).opacity(0.6))
                            .tracking(2.4)
                            .textCase(.uppercase)
                    }
                    .opacity(taglineVisible ? 1 : 0)
                    .offset(y: taglineVisible ? 0 : 8)
                    .animation(.easeOut(duration: 0.8).delay(0.4), value: taglineVisible)

                    Spacer()

                    CenterExpandBarView()
                        .padding(.bottom, 56)
                }
                .frame(width: outerGeo.size.width, height: outerGeo.size.height)
            }
        }
        .onAppear {
            logoVisible = true
            taglineVisible = true
        }
    }
}

#Preview {
    LaunchAnimationView()
}
