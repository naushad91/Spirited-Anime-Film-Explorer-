//
//  SpiritedApp.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 14/01/26.
//

import SwiftUI

@main
struct SpiritedApp: App {
    @State private var showLaunch = true

    var body: some Scene {
        WindowGroup {
            if showLaunch {
                LaunchAnimationView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation(.easeInOut(duration: 0.6)) {
                                showLaunch = false
                            }
                        }
                    }
            } else {
                ContentView()
            }
        }
    }
}
