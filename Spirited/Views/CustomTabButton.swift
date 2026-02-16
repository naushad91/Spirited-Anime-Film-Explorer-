//
//  CustomTabButton.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/02/26.
//


import SwiftUI

struct CustomTabButton: View {

    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: isSelected ? .semibold : .regular))
                    .frame(height: 24)

                Text(title)
                    .font(.system(size: 11, weight: isSelected ? .semibold : .medium))
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(isSelected ? Color.blue : Color.gray)
            .contentShape(Rectangle())
        }
    }
}
