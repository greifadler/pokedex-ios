//
//  PokeError.swift
//  student721009
//
//  Created by hohe on 13.10.23.
//

import Foundation

enum PokeError: LocalizedError {
    
    case general
    case noInternet
    
    var errorDescription: String? {
        switch self {
        case .general:
            return "Something went wrong"
        case .noInternet:
            return "you appered to be offline"
        }
    }
}
