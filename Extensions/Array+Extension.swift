//
//  Array+Extension.swift
//  student721009
//
//  Created by hohe on 13.10.23.
//

import Foundation

extension Array where Element == Pokemon {
    static var test: [Pokemon] {
        return [
            Pokemon(id: 1, name: "Bisasam", imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
            Pokemon(id: 2, name: "Glumanda", imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png"),
            Pokemon(id: 3, name: "Schiggi", imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png"),
        ]
    }
}
