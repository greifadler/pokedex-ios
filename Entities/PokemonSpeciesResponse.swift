// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemonSpeciesResponse = try? JSONDecoder().decode(PokemonSpeciesResponse.self, from: jsonData)

import Foundation

// MARK: - PokemonSpeciesResponse
struct PokemonSpeciesResponse: Codable {
    let evolution_chain: EvolutionChain
    
}

struct EvolutionChain: Codable {
    let url: String
}
