//
//  PokemonListViewModel.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 28/01/2025.
//

import Foundation

class PokemonListViewModel: ViewModelBase {

    // MARK: - PROPERTIES
    var pokemonL: PokemonList?
    let webService = WebService()
    
    private let pageSize: Int = 20
    private var currentPage: Int = 0
    private var isLoading: Bool = false
    
    
    // MARK: - FUNCTIONS
    init(pokemonL: PokemonList? = nil) {
        self.pokemonL = pokemonL
    }
        
    var count: Int {
        pokemonL?.count ?? 0
    }
    
    var List: [results] {
        pokemonL?.results ?? [results(name: "", url: "")]
    }

    
    func getList() {
        
        guard !isLoading else { return }
        isLoading = true
        DispatchQueue.main.async {
            self.loadingState = .loading
        }
        
        
        let offset = currentPage * pageSize
        webService.getPokemonList(limit: pageSize, offset: offset) { result in
            
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    
                    if self.currentPage == 0 {
                        self.pokemonL = data
                    } else {
                        self.pokemonL?.results.append(contentsOf: data.results)
                    }
                    self.currentPage += 1
                    self.loadingState = .success
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.loadingState = .failed
                    }
                }
            }
        }
    }
    
    func filterByName(search: String) -> PokemonList {
        let filteredResults = pokemonL!.results.filter{ $0.name.hasPrefix(search.lowercased()) }
        return PokemonList(count: filteredResults.count, results: filteredResults)
    }
    
    
}
