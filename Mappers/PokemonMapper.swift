//
//  PokemonMapper.swift
//  student721009
//
//  Created by hohe on 13.10.23.
//

import Foundation

extension Pokemon {
    
    static func map(from entity: PokemonEntity, liked: Bool = false) -> Pokemon? {
        guard let idString = entity.url.split(separator: "/").last,
              let id = Int(idString) else {
            return nil
        }
        
        return Pokemon(
            id: id,
            name: entity.name.capitalized,
            imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png",
            liked: liked
        )
    }
}
