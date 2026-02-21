//
//  SettingsScreen.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/02/26.
//

import SwiftUI

struct SettingsScreen: View {
   
    @AppStorage(UserDefaultsKeys.appearanceTheme)
    private var appearanceTheme: AppearanceTheme = .system
    
    @AppStorage(UserDefaultsKeys.username)
    private var username: String = ""
    
    @AppStorage(UserDefaultsKeys.itemsPerPage)
    private var itemsPerPage: Int = 20
    
    @AppStorage(UserDefaultsKeys.notificationsEnabled)
    private var notificationsEnabled: Bool = true
    
    var body: some View {
        ZStack {
            LinearGradient.warmBackground
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Custom header
                    ScreenHeader(
                        title: "Settings",
                        subtitle: "Customize Your Experience"
                    )

                    VStack(spacing: 20) {
                        // Appearance Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Appearance")
                                .font(.system(size: 18, weight: .semibold, design: .serif))
                                .foregroundStyle(Color.warmGoldDeep)
                                .padding(.horizontal, 16)
                            
                            VStack(spacing: 0) {
                                ForEach(AppearanceTheme.allCases) { theme in
                                    Button {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                            appearanceTheme = theme
                                        }
                                    } label: {
                                        HStack(spacing: 12) {
                                            Image(systemName: theme.icon)
                                                .font(.system(size: 18))
                                                .foregroundStyle(Color.warmGoldDeep)
                                                .frame(width: 28)
                                            
                                            Text(theme.rawValue.capitalized)
                                                .font(.system(size: 16))
                                                .foregroundStyle(Color.warmTextDark)
                                            
                                            Spacer()
                                            
                                            if appearanceTheme == theme {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .font(.system(size: 20))
                                                    .foregroundStyle(Color.warmGoldDeep)
                                            }
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 14)
                                        .background(
                                            appearanceTheme == theme
                                            ? Color.warmGoldBright.opacity(0.1)
                                            : Color.clear
                                        )
                                    }
                                    
                                    if theme != AppearanceTheme.allCases.last {
                                        Divider()
                                            .padding(.leading, 56)
                                    }
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.warmBackgroundTop)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.warmGoldMid.opacity(0.3), lineWidth: 1)
                                    )
                                    .shadow(color: Color.warmGoldMid.opacity(0.15), radius: 8, x: 0, y: 3)
                            )
                            
                            Text("Overrides the system appearance setting")
                                .font(.caption)
                                .foregroundStyle(Color.warmTextSoft.opacity(0.6))
                                .padding(.horizontal, 16)
                        }
                        
                        // Account Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Account")
                                .font(.system(size: 18, weight: .semibold, design: .serif))
                                .foregroundStyle(Color.warmGoldDeep)
                                .padding(.horizontal, 16)
                            
                            HStack(spacing: 12) {
                                Image(systemName: "person.circle")
                                    .font(.system(size: 18))
                                    .foregroundStyle(Color.warmGoldDeep)
                                    .frame(width: 28)
                                
                                TextField("Username", text: $username)
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color.warmTextDark)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.warmBackgroundTop)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.warmGoldMid.opacity(0.3), lineWidth: 1)
                                    )
                                    .shadow(color: Color.warmGoldMid.opacity(0.15), radius: 8, x: 0, y: 3)
                            )
                        }
                        
                        // Preferences Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Preferences")
                                .font(.system(size: 18, weight: .semibold, design: .serif))
                                .foregroundStyle(Color.warmGoldDeep)
                                .padding(.horizontal, 16)
                            
                            VStack(spacing: 0) {
                                // Items per page
                                HStack(spacing: 12) {
                                    Image(systemName: "list.number")
                                        .font(.system(size: 18))
                                        .foregroundStyle(Color.warmGoldDeep)
                                        .frame(width: 28)
                                    
                                    Text("Items per page")
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color.warmTextDark)
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 8) {
                                        Button {
                                            if itemsPerPage > 10 {
                                                itemsPerPage -= 5
                                            }
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.system(size: 24))
                                                .foregroundStyle(itemsPerPage > 10 ? Color.warmGoldDeep : Color.warmTextSoft.opacity(0.3))
                                        }
                                        .disabled(itemsPerPage <= 10)
                                        
                                        Text("\(itemsPerPage)")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(Color.warmTextDark)
                                            .frame(width: 40)
                                        
                                        Button {
                                            if itemsPerPage < 100 {
                                                itemsPerPage += 5
                                            }
                                        } label: {
                                            Image(systemName: "plus.circle.fill")
                                                .font(.system(size: 24))
                                                .foregroundStyle(itemsPerPage < 100 ? Color.warmGoldDeep : Color.warmTextSoft.opacity(0.3))
                                        }
                                        .disabled(itemsPerPage >= 100)
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 14)
                                
                                Divider()
                                    .padding(.leading, 56)
                                
                                // Notifications toggle
                                HStack(spacing: 12) {
                                    Image(systemName: "bell.fill")
                                        .font(.system(size: 18))
                                        .foregroundStyle(Color.warmGoldDeep)
                                        .frame(width: 28)
                                    
                                    Text("Enable notifications")
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color.warmTextDark)
                                    
                                    Spacer()
                                    
                                    Toggle("", isOn: $notificationsEnabled)
                                        .labelsHidden()
                                        .tint(Color.warmGoldDeep)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 14)
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.warmBackgroundTop)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.warmGoldMid.opacity(0.3), lineWidth: 1)
                                    )
                                    .shadow(color: Color.warmGoldMid.opacity(0.15), radius: 8, x: 0, y: 3)
                            )
                        }
                        
                        // Reset Button
                        Button {
                            resetDefaults()
                        } label: {
                            HStack {
                                Spacer()
                                Image(systemName: "arrow.counterclockwise")
                                Text("Reset to Defaults")
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                            }
                            .foregroundStyle(.white)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.pink)
                                    .shadow(color: Color.pink.opacity(0.3), radius: 8, x: 0, y: 3)
                            )
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private func resetDefaults() {
        appearanceTheme = .system
        username = ""
        itemsPerPage = 20
        notificationsEnabled = true
    }
}

//MARK: - data model for appearance
enum AppearanceTheme: String, Identifiable, CaseIterable {
    case system
    case light
    case dark
    
    var id: Self { return self }
    
    var icon: String {
        switch self {
        case .system: return "circle.lefthalf.filled"
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        }
    }
}

//MARK: - helper to save user defaults keys and keep them unique
enum UserDefaultsKeys {
    static let appearanceTheme = "appearanceTheme"
    static let username = "username"
    static let itemsPerPage = "itemsPerPage"
    static let notificationsEnabled = "notificationsEnabled"
}

//MARK: - helper to set saved theme
extension View {
    func setAppearanceTheme() -> some View {
        modifier(AppearanceThemeViewModifier())
    }
}

struct AppearanceThemeViewModifier: ViewModifier {
    
    @AppStorage(UserDefaultsKeys.appearanceTheme) private var appearanceTheme: AppearanceTheme = .system
    
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(scheme())
    }
    
    func scheme() -> ColorScheme? {
        switch appearanceTheme {
        case .dark: return .dark
        case .light: return .light
        case .system: return nil
        }
    }
}

//MARK: - Preview
#Preview {
    NavigationStack {
        SettingsScreen()
    }
}
