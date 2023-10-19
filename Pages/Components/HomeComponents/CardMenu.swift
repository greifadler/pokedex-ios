//
//  SettingsView.swift
//  student721009
//
//  Created by hohe on 18.10.23.
//

import SwiftUI

struct CardMenu: View {
    
    let url : URL
    let pokemon: Pokemon
    
    @EnvironmentObject
    var pokemonStore: PokemonStore
    
    @State private var navigateTo = ""
    @State private var isActive = false
    
    
    
    var body: some View {
        
        Menu
        {
            //ShareLink(
            //    item: url,
            //    preview:
            //        SharePreview("Share", image: Image(systemName: "square.and.arrow.up"))
            //)
            
            Button {
                        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
            
            Button(action: {
                self.isActive = true
            }) {
                Text("Open Pokemon")
                Image(systemName: "arrow.right.circle")
            }
            

            
            if(pokemon.liked) {
                Button(action: {
                    pokemonStore.unlikePokemon(id: pokemon.id)
                }) {
                    Text("Unlike Pokemon")
                    Image(systemName: "heart.slash")
                }
            } else {
                Button(action: {
                    pokemonStore.likePokemon(id: pokemon.id)
                }) {
                    Text("Like Pokemon")
                    Image(systemName: "heart")
                }
            }
            
        }
    label: {
        Image("Settings3Dots")
            .resizable()
            .frame(width: 24, height: 24)
        
    }
    .background(
        NavigationLink(destination: PokemonDetailPage(pokemon: pokemon), isActive: $isActive) {
        EmptyView()
    })
        
        
    }
}
