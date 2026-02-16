//
//  SearchScreen.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/02/26.
//

import SwiftUI

struct SearchScreen: View {

    @State private var text: String = ""

    var body: some View {
        NavigationStack {
            Text("Show search here")
                .navigationTitle("Search")
        }
        .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always))
    }
}

#Preview {
    SearchScreen()
}
