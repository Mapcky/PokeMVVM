//
//  PokemonViewModel.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import Foundation

class PokemonViewModel: ViewModelBase {
    
    private var pokemon: Pokemon?
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
    
    func getPokemonByName(name: String) {
        self.loadingState = .loading
        webService.getPokemonByName(name: name) { result in
            switch result {
            case .success(let data):

                DispatchQueue.main.async {
                    self.pokemon = data
                    self.loadingState = .success
                }
            case .failure(let error):

                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.loadingState = .failed
                }
                
            }
            
        }
    }
    
    
    func getPokemonByUrl(url: String) {
        self.loadingState = .loading
        webService.getPokemonByUrl(url: url) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.pokemon = data
                    self.loadingState = .success
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.loadingState = .failed
                }
            }
        }
    }
}

