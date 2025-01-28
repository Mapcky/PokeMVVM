//
//  PokemonList.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 28/01/2025.
//

import Foundation

struct PokemonList: Decodable {
    var count: Int
    var results: [results]
    

    
}

struct results: Decodable {
    var name: String
    var url: String
}
