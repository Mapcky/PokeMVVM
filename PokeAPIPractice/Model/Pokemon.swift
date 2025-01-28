//
//  Pokemon.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import Foundation

struct Pokemon: Decodable {
    var name: String
    var id: Int
    var height: Int
    var sprites: sprites
    
    
    struct sprites: Decodable {
        var front_default: String
        var front_shiny: String
    }
}
