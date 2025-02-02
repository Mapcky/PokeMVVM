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
    
    static func urlGetPokemonList(limit: Int, offset: Int) -> URL? {
        return URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)")
    }
}
