//
//  PokemonDetailPage.swift
//  student721009
//
//  Created by hohe on 13.10.23.
//

import Foundation
import SwiftUI

struct PokemonDetailPage: View {
    
    let pokemon: Pokemon
    
    @EnvironmentObject
    var pokemonStore: PokemonStore
    
    @StateObject
    var detailStore = PokemonDetailStore()
    
    
    @State private var liked: Bool
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        _liked = State(initialValue: pokemon.liked)
    }
    
    
    
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Color("BGColored")
                        .frame(maxHeight: 380)
                    Spacer()
                        .background(Color("BGClean"))
                }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack() {
                    HStack {
                        Text(pokemon.name)
                            .font(
                                Font.custom("Cabinet Grotesk Variable", size: 32)
                                    .weight(.heavy)
                            )
                            .multilineTextAlignment(.trailing)
                        
                        Spacer()
                        
                        Text("#" + pokemon.id.formatPokedexNumber())
                            .font(Font.custom("Cabinet Grotesk Variable", size: 24))
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    
                    
                    
                    if let details = detailStore.details {
                        switch details {
                        case .success(let details):
                            Details(details: details, pokemon: pokemon)
                                .environmentObject(detailStore)
                        case .failure:
                            ReloadDetails(reloadAction: {
                                Task {
                                    await detailStore.fetchDetails(for: pokemon)
                                }
                            })
                        }
                    } else {
                        ProgressView()
                    }
                    
                    Spacer()
                }
            }
        }
        .frame(alignment: .top)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
            // Handle the heart icon tap action here
        }) {
            if (liked) {
                Button(action: {
                    pokemonStore.unlikePokemon(id: pokemon.id)
                    liked.toggle()
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            } else {
                Button(action: {
                    liked.toggle()
                    pokemonStore.likePokemon(id: pokemon.id)
                }) {
                    Image(systemName: "heart")
                        .foregroundColor(.black)
                }
            }
            
        }
        )
        .task {
            await detailStore.fetchDetails(for: pokemon)
        }
    }
    
}



#Preview {
    NavigationView {
        PokemonDetailPage(pokemon: .test)
    }
}

