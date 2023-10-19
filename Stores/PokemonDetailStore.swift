//
//  PokemonDetailStore.swift
//  student721009
//
//  Created by hohe on 13.10.23.
//

import Foundation

@MainActor
class PokemonDetailStore: ObservableObject {
    
    @Published
    var details: Result<PokemonDetailsResponse, Error>?
    
    @Published
    var evolutionChain: Result<[String], Error>?
    
    
    func fetchDetails(for pokemon: Pokemon) async {
        do {
            let urlTemplate = "https://pokeapi.co/api/v2/pokemon/{id}"
            let finalURL = urlTemplate.replacingOccurrences(of: "{id}", with: "\(pokemon.id)")
            
            guard let url = URL(string: finalURL) else {
                throw PokeError.general
            }
            let urlRequest = URLRequest(url: url, timeoutInterval: 5000)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let pokemonResponse = try JSONDecoder().decode(PokemonDetailsResponse.self, from: data)
            let pokemon: PokemonDetailsResponse = pokemonResponse
            self.details = .success(pokemon)
            
        } catch {
            print("something went wrong: \(error)")
            details = .failure(error)
        }
    }

    func fetchEvolutions(for pokemonId: Int) async {
        do {
            let evolutionLink = await fetchEvolutionLinkId(for: pokemonId)

            guard let url = URL(string: evolutionLink) else {
                throw PokeError.general
            }
            let urlRequest = URLRequest(url: url, timeoutInterval: 5000)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let pokemonResponse = try JSONDecoder().decode(PokemonEvolutionResponse.self, from: data)
            let pokemon: [String] = pokemonResponse
                .chain
                .extractEvolutionNames()
            
            self.evolutionChain = .success(pokemon)
            
        } catch {
            print("something went wrong: \(error)")
            self.evolutionChain = .failure(error)
        }
    }
    
    private func fetchEvolutionLinkId(for pokemonId: Int) async -> String {
        do {
            let urlTemplate = "https://pokeapi.co/api/v2/pokemon-species/{id}"
            let finalURL = urlTemplate.replacingOccurrences(of: "{id}", with: "\(pokemonId)")
            
            guard let url = URL(string: finalURL) else {
                throw PokeError.general
            }
            let urlRequest = URLRequest(url: url, timeoutInterval: 5000)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let pokemonResponse = try JSONDecoder().decode(PokemonSpeciesResponse.self, from: data)
            return pokemonResponse.evolution_chain.url
            
        } catch {
            print("something went wrong: \(error)")
            return ""
        }
    }
}
