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
    var height: Double
    var sprites: sprites
    var weight: Double
    var types: [PokemonTypeEntry]
    
    struct sprites: Decodable {
        var front_default: String
        var front_shiny: String
    }
    
    struct PokemonTypeEntry: Decodable {
        var slot: Int
        var type: TypeInfo
    }

    struct TypeInfo: Decodable {
        var name: String
        var url: String
    }
    
}
