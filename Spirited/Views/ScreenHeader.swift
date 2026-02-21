//
//  ScreenHeader.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 21/02/26.
//


import SwiftUI

struct ScreenHeader: View {
    let title: String
    let subtitle: String
    var titleColor: Color = .warmGoldDeep
    var subtitleColor: Color = .warmTextSoft.opacity(0.6)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 34, weight: .bold, design: .serif))
                .foregroundStyle(titleColor)
            
            Text(subtitle)
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .tracking(1.5)
                .foregroundStyle(subtitleColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 16)
    }
}
