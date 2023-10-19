//
//  FavouritePokemonStore.swift
//  student721009
//
//  Created by hohe on 18.10.23.
//

import Foundation

class FavouritePokemonsStore {
    static let shared = FavouritePokemonsStore()

    private let likedPokemonsKey = "LikedPokemons"

    private init() {
        // Initialize the store, load previously liked Pokemon IDs from UserDefaults
        loadLikedPokemons()
    }

    // Private property to store liked Pokemon IDs
    private var likedPokemonIDs: Set<Int> = []

    // Function to like a Pokemon by adding its ID to the set
    func likePokemon(id: Int) {
        likedPokemonIDs.insert(id)
        saveLikedPokemons()
    }

    // Function to unlike a Pokemon by removing its ID from the set
    func unlikePokemon(id: Int) {
        likedPokemonIDs.remove(id)
        saveLikedPokemons()
    }

    // Function to check if a Pokemon is liked
    func isLiked(id: Int) -> Bool {
        return likedPokemonIDs.contains(id)
    }

    // Function to save liked Pokemon IDs to UserDefaults
    private func saveLikedPokemons() {
        UserDefaults.standard.set(Array(likedPokemonIDs), forKey: likedPokemonsKey)
    }

    // Function to load liked Pokemon IDs from UserDefaults
    private func loadLikedPokemons() {
        if let likedIDs = UserDefaults.standard.array(forKey: likedPokemonsKey) as? [Int] {
            likedPokemonIDs = Set(likedIDs)
        }
    }
}
