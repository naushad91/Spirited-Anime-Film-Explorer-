//
//  Color+Theme.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/02/26.
//

// MARK: - Theme Colors
import SwiftUI

@MainActor
extension Color {
    static let warmBackground     = Color(red: 255/255, green: 253/255, blue: 230/255)
    static let warmBackgroundTop  = Color(red: 255/255, green: 255/255, blue: 250/255)
    static let warmBackgroundBot  = Color(red: 255/255, green: 249/255, blue: 210/255)
    static let warmGoldBright     = Color(red: 255/255, green: 200/255, blue: 60/255)
    static let warmGoldMid        = Color(red: 255/255, green: 160/255, blue: 30/255)
    static let warmGoldDeep       = Color(red: 240/255, green: 120/255, blue: 10/255)
    static let warmTextDark       = Color(red: 40/255,  green: 25/255,  blue: 5/255)
    static let warmTextMid        = Color(red: 100/255, green: 65/255,  blue: 15/255)
    static let warmTextSoft       = Color(red: 60/255,  green: 40/255,  blue: 10/255)
}

@MainActor
extension LinearGradient {
    static let warmGold = LinearGradient(
        colors: [.warmGoldBright, .warmGoldMid, .warmGoldDeep],
        startPoint: .leading,
        endPoint: .trailing
    )
    static let warmBackground = LinearGradient(
        colors: [.warmBackgroundTop, .warmBackground, .warmBackgroundBot],
        startPoint: .top,
        endPoint: .bottom
    )
}
