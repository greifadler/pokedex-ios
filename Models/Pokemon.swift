//
//  Pokemon.swift
//  student721009
//
//  Created by hohe on 13.10.23.
//

import Foundation

struct Pokemon: Identifiable {
    
    let id: Int
    let name: String
    let imageUrl: String
    var liked: Bool
    
    init(id: Int, name: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.liked = false
    }
    
    init(id: Int, name: String, imageUrl: String, liked: Bool) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.liked = liked
    }
    
    
    //image etc.
}
