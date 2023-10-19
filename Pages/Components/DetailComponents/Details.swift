//
//  Details.swift
//  student721009
//
//  Created by hohe on 18.10.23.
//

import SwiftUI

struct Details: View {
    
    @EnvironmentObject
    var pokemonDetailsStore: PokemonDetailStore
    
    let details: PokemonDetailsResponse
    let pokemon: Pokemon
    
    enum Tab {
        case about, stats, evolution
    }
    
    @State private var selectedTab: Tab = .about

    var body: some View {
        VStack {
            HStack {
                ForEach(details.types) { type in
                    TypeCard(type.type.name.capitalized)
                    Text("")
                }
                Spacer()
            }
            .frame(width: .infinity, alignment: .leading)
            .padding()
            
            LazyImage(imageURL: URL(string: pokemon.imageUrl), // Use the 'pokemon' property for the imageURL
                      imageSize: CGSize(width: 200, height: 200),
                      backgroundColor: .clear
            )
            
            HStack {
                SegmentButton(title: "About", tab: .about, selectedTab: $selectedTab)
                SegmentButton(title: "Stats", tab: .stats, selectedTab: $selectedTab)
                SegmentButton(title: "Evolution", tab: .evolution, selectedTab: $selectedTab)
            }
            .padding()
            
            ScrollView {
                switch selectedTab {
                case .about:
                    About(details: details)
                case .stats:
                    Stats(details: details)
                case .evolution:
                    Evolutions()
                        .task {
                            await pokemonDetailsStore.fetchEvolutions(for: pokemon.id)
                        }
                }
            }
        }
    }
}
