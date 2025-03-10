//
//  PokemonViewModel.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import Foundation
import Observation

@MainActor
@Observable
class PokemonViewModel: ObservableObject {
    // MARK: - PROPERTIES
    var pokemon: Pokemon?
    private var webService = WebService()
    
    // MARK: - INIT
    init(pokemon: Pokemon? = nil, url: String?) {
        self.pokemon = pokemon
        getPokemonByUrl(url: url ?? "")
    }
    
    
    var name: String {
        guard let pokemonName = pokemon?.name, let first = pokemonName.first else {
            return ""
        }
        return first.uppercased() + pokemonName.dropFirst()
    }
    
    var id: String {
        String(pokemon?.id ?? 0)
    }
    
    var height: String {
        guard let height = pokemon?.height  else {
            return ""
        }
        if height >= 10 {
            return "\(height/10) m"
        }
        else {
            return "\(height*10) cm"
        }
    }
    
    var weight: String {
        guard let weight = pokemon?.weight  else {
            return ""
        }
        return "\(weight/10) kg"
    }
    
    var spriteNormal: String {
        pokemon?.sprites?.front_default ?? ""
    }
    
    var spriteShiny: String {
        pokemon?.sprites?.front_shiny ?? ""
    }
    
    var firstType: String {
        guard let firstType = pokemon?.types.first?.type.name, let first = firstType.first else {
            return ""
        }
        return first.uppercased() + firstType.dropFirst()
    }
    
    var secondType: String {
        if pokemon?.types.count ?? 0 > 1 {
            guard let secondType = pokemon?.types.last?.type.name, let first = secondType.first else { return "" }
            
            return first.uppercased() + secondType.dropFirst()
        }
        return ""
    }
    
    var abilities: [Abilities] {
        guard let abilities = pokemon?.abilities else { return  [] }
        return abilities
    }
    
    // MARK: - FUNCTIONS
    func getPokemonByName(name: String) {
        webService.getPokemonByName(name: name) { result in
            switch result {
            case .success(let data):
                self.pokemon = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getPokemonByUrl(url: String) {
        webService.getPokemonByUrl(url: url) { result in
            switch result {
            case .success(let data):
                self.pokemon = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

