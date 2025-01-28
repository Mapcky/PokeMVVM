//
//  URL+Extensions.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import Foundation

extension URL {
    static func urlGetPokemon(pokemon: String) -> URL? {
        return URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon)")
    }
    
    static func urlGetPokemonList() -> URL? {
        return URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0")
    }
}
