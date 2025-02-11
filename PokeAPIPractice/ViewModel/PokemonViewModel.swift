//
//  PokemonViewModel.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import Foundation

class PokemonViewModel: ObservableObject {
    
    @Published private var pokemon: Pokemon?
    private var webService = WebService()
    
    
    
    init(pokemon: Pokemon? = nil) {
        self.pokemon = pokemon
    }
    
    let uuid = UUID()
    
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
        pokemon?.sprites.front_default ?? ""
    }
    
    var spriteShiny: String {
        pokemon?.sprites.front_shiny ?? ""
    }
    
    var firstType: String {
        pokemon?.types.first?.type.name ?? ""
    }
    
    
    func getPokemonByName(name: String) {
        webService.getPokemonByName(name: name) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.pokemon = data
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getPokemonByUrl(url: String) {
        webService.getPokemonByUrl(url: url) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.pokemon = data
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

