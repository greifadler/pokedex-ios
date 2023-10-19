//
//  PokemonEvolutionResponse.swift
//  student721009
//
//  Created by hohe on 19.10.23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemonEvolutionResponse = try? JSONDecoder().decode(PokemonEvolutionResponse.self, from: jsonData)

import Foundation

struct PokemonEvolutionResponse: Codable {
    let chain: Chain
    let id: Int
}

// MARK: - Chain
struct Chain: Codable {
    let evolves_to: [Chain]
    let is_baby: Bool
    let species: SpeciesEvol
    
}


// MARK: - Species
struct SpeciesEvol: Codable {
    let name: String
    let url: String
}

extension Chain {
    func extractEvolutionNames() -> [String] {
        var names = [self.species.name]

        for evolution in self.evolves_to {
            names.append(contentsOf: evolution.extractEvolutionNames())
        }

        return names
    }
}
