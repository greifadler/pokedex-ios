//
//  PokemonResponse.swift
//  student721009
//
//  Created by hohe on 13.10.23.
//

import Foundation


struct PokemonResponse: Codable {
    let results: [PokemonEntity]
}

struct PokemonEntity: Codable {
    let name: String
    let url: String
}
