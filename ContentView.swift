//
//  ContentView.swift
//  student721009
//
//  Created by hohe on 13.10.23.
//

import SwiftUI

struct ContentView: View {
    
    @State var isActive = false
    
    @StateObject
    var pokemonStore = PokemonStore()
    
    var body: some View {
        VStack {
            if (self.isActive) {
                TabView {
                    NavigationView {
                        HomePage(showOnlyLiked: false)
                            .navigationTitle("All Pokémon’s")
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button(action: {
                                        pokemonStore.reload()
                                    }) {
                                        Image(systemName: "arrow.clockwise.circle")
                                            .imageScale(.large)
                                    }
                                }
                            }
                        
                    }
                    .environmentObject(pokemonStore)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Pokémon")
                    }
                    
                    
                    NavigationView {
                        HomePage(showOnlyLiked: true)
                            .navigationTitle("Favourites")
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button(action: {
                                        pokemonStore.reload()
                                    }) {
                                        Image(systemName: "arrow.clockwise.circle")
                                            .imageScale(.large)
                                    }
                                }
                            }
                    }
                    .environmentObject(pokemonStore)
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favourites")
                    }
                }
            } else {
                SplashPage()
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
    
}

#Preview {
    ContentView()
        .environmentObject(PokemonStore())
}
