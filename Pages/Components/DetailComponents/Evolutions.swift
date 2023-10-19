//
//  Evolutions.swift
//  student721009
//
//  Created by hohe on 18.10.23.
//

import SwiftUI

struct Evolutions: View {
    
    @EnvironmentObject
    var pokemonDetailsStore: PokemonDetailStore
    
    @EnvironmentObject
    var pokemonStore: PokemonStore
    
    
    var body: some View {
        
        if let details = pokemonDetailsStore.evolutionChain {
            switch details {
            case .success(let evolutions):
                ForEach(evolutions, id: \.self) { evolution in
                    
                    PokemonEvolutionCard(pokemonName: evolution, additionalData: pokemonStore.findPokemonByName(evolution))
                }
            case .failure:
                ReloadDetails(reloadAction: {
                    Task {
                      //  await pokemonDetailsStore.fetchEvolutions(for: pokemon.id)
                    }
                })
            }
        } else {
            ProgressView()
        }
        
        // Use the details parameter to display information from PokemonDetailsResponse
    }
    
}

struct PokemonEvolutionCard: View {
    let pokemonName: String

    let additionalData: (id: Int, imageUrl: String)

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
   
            
            LazyImage(imageURL: URL(string: additionalData.imageUrl), imageSize: CGSize(width: 80, height: 80), backgroundColor: Color("BGGray"))
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .center, spacing: 10) {
                    Text(additionalData.id == -1 ? "???" : additionalData.id.formatPokedexNumber())
                        .font(
                            Font.custom("Rubik", size: 10)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("DarkTextColor"))
                        .padding(.horizontal, 6)
                        .padding(.top, 4)
                        .padding(.bottom, 2)
                        .background(Color("AccentColor"))
                        .cornerRadius(4)
                }
                
                Text(pokemonName.capitalized)
                    .font(
                        Font.custom("Rubik", size: 16)
                            .weight(.medium)
                    )
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding()
        }
        .frame(width: 342, height: 80, alignment: .topLeading)
        .background(Color("BGClean"))
        .cornerRadius(8)
        .shadow(color: Color(red: 0.19, green: 0.22, blue: 0.45).opacity(0.15), radius: 7.5, x: 0, y: 2)
    }
}

