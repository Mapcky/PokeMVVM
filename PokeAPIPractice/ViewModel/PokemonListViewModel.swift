//
//  PokemonListViewModel.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 28/01/2025.
//

import Foundation

class PokemonListViewModel: ViewModelBase {

    var pokemonL: PokemonList?
    let webService = WebService()
    
    init(pokemonL: PokemonList? = nil) {
        self.pokemonL = pokemonL
    }
    
    var firstPokemon: String {
        pokemonL?.results.first?.name ?? "nil"
    }
    
    var count: Int {
        pokemonL?.count ?? 0
    }
    
    var List: [results] {
        pokemonL?.results ?? [results(name: "vacio", url: "")]
    }

    
    func getList() {
        self.loadingState = .loading
        webService.getPokemonList { result in
            switch result {
                
            case .success(let data):
                DispatchQueue.main.async {
                    self.pokemonL = data
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
