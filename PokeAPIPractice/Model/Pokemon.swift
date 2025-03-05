//
//  Pokemon.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import Foundation

struct Pokemon: Codable, Hashable {
    var name: String
    var id: Int
    var height: Double
    var sprites: sprites?
    var weight: Double
    var types: [PokemonTypeEntry]
    var abilities: [Abilities]
    var stats: [StatEntry]
    
    struct sprites: Codable, Hashable {
        var front_default: String
        var front_shiny: String
    }
    
    struct PokemonTypeEntry: Codable, Hashable {
        var slot: Int
        var type: TypeInfo
    }
    
    struct TypeInfo: Codable, Hashable {
        var name: String
        var url: String
    }
    
    
}

struct Abilities: Codable, Hashable {
    var ability: Ability
    var is_hidden: Bool
    
    
    struct Ability: Codable, Hashable {
        var name: String
        var url: String
    }
}

struct StatEntry: Codable, Hashable {
    var baseStat: Int
    var effort: Int
    var stat: Stat
    
    struct Stat: Codable, Hashable {
        var name: String
        var url: String
    }
    
    private enum CodingKeys: String, CodingKey {
        case effort, stat
        case baseStat = "base_stat"
    }
}
