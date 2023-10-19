//
//  About.swift
//  student721009
//
//  Created by hohe on 18.10.23.
//

import SwiftUI

struct About: View {
    let details: PokemonDetailsResponse
    
    var body: some View {
        VStack {
            AboutRow(label: "Name:", value: details.name.capitalized)
            AboutRow(label: "ID:", value: details.id.formatPokedexNumber())
            AboutRow(label: "Base:", value: details.baseExperience.formatted() + " XP")
            AboutRow(label: "Weight:", value: details.weight.formatted() + " kg")
            AboutRow(label: "Height:", value: details.height.formatted() + " m")
            AboutRow(label: "Types:", value: details.types.map { $0.type.name.capitalized }.joined(separator: ", "))
            AboutRow(label: "Abilities:", value: details.abilities.map { $0.ability.name.capitalized }.joined(separator: ", "))
        }
        .padding()
    }
}

struct AboutRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(
                    Font.custom("Rubik", size: 14)
                        .weight(.semibold)
                )
                .foregroundColor(Color("TextColor"))
                .frame(maxWidth: .infinity * 0.3, alignment: .topLeading)
            
            Text(value)
                .font(Font.custom("Rubik", size: 14))
                .foregroundColor(Color("DisabledTextColor"))
                .frame(maxWidth: .infinity * 0.7, alignment: .topLeading)
        }
        .padding(8)
    }
}
