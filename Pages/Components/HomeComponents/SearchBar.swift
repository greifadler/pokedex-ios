//
//  SearchBar.swift
//  student721009
//
//  Created by hohe on 18.10.23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "magnifyingglass")
                .frame(width: 24, height: 24)
                .foregroundColor(Color("TextColor"))
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))

            TextField("Search for Pokémon..", text: $searchText)
                .font(Font.custom("Inter", size: 16))
                .foregroundColor(Color("TextColor"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                
        }
        .background(Color("DarkTextColor"))
        .cornerRadius(8)
        .shadow(color: Color(red: 0.19, green: 0.22, blue: 0.45).opacity(0.15), radius: 7.5, x: 0, y: 2)
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))


    }
}
