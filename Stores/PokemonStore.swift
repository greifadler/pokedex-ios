//
//  PokemonStore.swift
//  student721009
//
//  Created by hohe on 13.10.23.
//

import Foundation

@MainActor
class PokemonStore: ObservableObject {
    
    @Published var pokemon: Result<[Pokemon], Error>?
    
    @Published var isLoading = false
    @Published private var offsetVal = 0
    
    let favs = FavouritePokemonsStore.shared
    
    init(pokemon: Result<[Pokemon], Error>? = nil) {
        self.pokemon = pokemon
        Task { await setup() }
    }
    
    // Function to like a Pokemon by adding its ID to the set
    func likePokemon(id: Int) {
        if case var .success(pokemonList) = pokemon {
            if let index = pokemonList.firstIndex(where: { $0.id == id }) {
                pokemonList[index].liked = true
                self.pokemon = .success(pokemonList)
                favs.likePokemon(id: id)
            }
        }
    }
    
    // Function to unlike a Pokemon by removing its ID from the set
    func unlikePokemon(id: Int) {
        if case var .success(pokemonList) = pokemon {
            if let index = pokemonList.firstIndex(where: { $0.id == id }) {
                pokemonList[index].liked = false
                self.pokemon = .success(pokemonList)
                favs.unlikePokemon(id: id)
            }
        }
    }
    
    
    func findPokemonByName(_ name: String) -> (id: Int, imageUrl: String) {
        let lowercaseName = name.lowercased()
        
        switch pokemon {
        case .success(let pokemonList):
            if let matchingPokemon = pokemonList.first(where: { $0.name.lowercased() == lowercaseName }) {
                return (id: matchingPokemon.id, imageUrl: matchingPokemon.imageUrl)
            } else {
                return (id: -1, imageUrl: "")
            }
            
        case .failure:
            return (id: -1, imageUrl: "")
        case nil:
            return (id: -1, imageUrl: "")
        }
    }
    
    func reload() {
        Task { await setup() }
    }
    
    func loadMoreContentIfNeeded(currentItem item: Pokemon) {
        
        switch pokemon {
        case .success(let pokemonList):
            
            let thresholdIndex = pokemonList.index(pokemonList.endIndex, offsetBy: -5)
            if pokemonList.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
                Task { await loadMoreContent() }
            }
            
        case .failure:
            Task { await setup() }
        case nil:
            Task { await setup() }
        }
    }
    
    func loadMoreContent() async {
        do {
            offsetVal += 20
            
            let urlTemplate = "https://pokeapi.co/api/v2/pokemon?limit=20&offset={offsetVal}"
            let finalURL = urlTemplate.replacingOccurrences(of: "{offsetVal}", with: "\(offsetVal)")
            guard let url = URL(string: finalURL) else {
                throw PokeError.general
            }
            let urlRequest = URLRequest(url: url, timeoutInterval: 5000)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let pokemonResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
            let pokemon: [Pokemon] = pokemonResponse
                .results
                .compactMap { entity in
                    let pkm = Pokemon.map(from: entity)
                    guard var pkm = pkm else { return nil }
                    pkm.liked = favs.isLiked(id: pkm.id)
                    return pkm
                }
            if case .success(let currentPokemon) = self.pokemon {
                let combinedPokemon = currentPokemon + pokemon
                self.pokemon = .success(combinedPokemon)
            }
        } catch {
            print("something went wrong: \(error)")
            pokemon = .failure(error)
        }
    }
    
    
    
}

private extension PokemonStore {
    
    func setup() async {
        do {
            isLoading = true
            self.pokemon = .success([])
            offsetVal = 0
            
            
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else {
                throw PokeError.general
            }
            let urlRequest = URLRequest(url: url, timeoutInterval: 5000)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let pokemonResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
            let pokemon: [Pokemon] = pokemonResponse
                .results
                .compactMap { entity in
                    let pkm = Pokemon.map(from: entity)
                    guard var pkm = pkm else { return nil }
                    pkm.liked = favs.isLiked(id: pkm.id)
                    return pkm
                }
            self.pokemon = .success(pokemon)
            isLoading = false
            
        } catch {
            print("something went wrong: \(error)")
            pokemon = .failure(error)
            isLoading = false
        }
    }
}


