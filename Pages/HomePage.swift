//
//  HomePage.swift
//  student721009
//
//  Created by hohe on 13.10.23.
//

import Foundation
import SwiftUI

struct HomePage: View {
    
    let showOnlyLiked: Bool
    
    @EnvironmentObject
    var pokemonStore: PokemonStore
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var searchText = ""
    
    var body: some View {
        if(pokemonStore.isLoading) {
            ProgressView()
        } else if let pokemon = pokemonStore.pokemon {
            switch pokemon {
            case .success(let pokemons):
                
                VStack {
                    SearchBar(searchText: $searchText)
                    ScrollView {
                        if(pokemons.filter { pokemon in
                            return (!showOnlyLiked || (showOnlyLiked && pokemon.liked)) &&
                            (searchText.isEmpty || (!searchText.isEmpty && pokemon.name.lowercased().contains(searchText.lowercased())))
                        }.count > 0) {
                            
                            
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(pokemons) { pokemon in
                                    if(!showOnlyLiked || (showOnlyLiked && pokemon.liked)) {
                                        if(searchText.isEmpty ||
                                           (!searchText.isEmpty && pokemon.name.lowercased().contains(searchText.lowercased()))) {
                                            PokemonCard(pokemon: pokemon)
                                                .onAppear {
                                                              pokemonStore.loadMoreContentIfNeeded(currentItem: pokemon)
                                                            }
                                            
                                        }
                                    }
                                }
                            }
                            .padding()
                        } else {
                            Text(showOnlyLiked ? "No liked Pokémons found" : "No Pokémons found")
                                .padding()
                        }
                    }
                }
                .background(Color("BGColored"))
                
                
                
                
            case .failure(let failure):
                Text("something went wrong")
            }
        } else {
            
        }
    }
    
}







#Preview {
    NavigationView {
        HomePage(showOnlyLiked: false)
            .environmentObject(PokemonStore(pokemon:
                    .success(.test)))
    }
}

