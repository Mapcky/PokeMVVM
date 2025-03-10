//
//  PokemonListViewModel.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 28/01/2025.
//

import Foundation
import Observation

@MainActor
@Observable
class PokemonListViewModel: ObservableObject {

    // MARK: - PROPERTIES
    var pokemonL: PokemonList?
    var List: [Results] = []
    var currentPage: Int = 0
    var isSearching: Bool = false
    let webService = WebService()
    
    private let pageSize: Int = 50
    private var isLoading: Bool = false
    
    var count: Int {
        pokemonL?.count ?? 0
    }
    
    // MARK: - FUNCTIONS
    init(pokemonL: PokemonList? = nil) {
        self.pokemonL = pokemonL
    }
        
    func getFullList() {
        webService.getPokemonList(limit: 100000, offset: 0) { result in
            switch result {
            case .success(let data):
                self.pokemonL = data
                self.loadNextPage()
                self.currentPage += 1
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadNextPage() {
        if !isSearching {
            guard currentPage * pageSize < pokemonL?.results.count ?? 0 else { return }
            let startIndex = currentPage * pageSize
            let endIndex = min(startIndex + pageSize, pokemonL?.results.count ?? 0)
            let newPokemon = Array(pokemonL!.results[startIndex..<endIndex])
            self.List.append(contentsOf: newPokemon)
            self.currentPage += 1
        }
    }
    
    func getListWithPaging() {
        guard !isLoading else { return }
        isLoading = true
        let offset = currentPage * pageSize
        webService.getPokemonList(limit: pageSize, offset: offset) { result in
            
            self.isLoading = false
            switch result {
            case .success(let data):
                
                if self.currentPage == 0 {
                    self.pokemonL = data
                } else {
                    self.pokemonL?.results.append(contentsOf: data.results)
                }
                self.currentPage += 1
                
            case .failure(let error):
                print(error.localizedDescription)
            }//: switch
        }//: Webservice
    }
    
    func filterByName(search: String) {
        let filteredResults = pokemonL!.results.filter{ $0.name.hasPrefix(search.lowercased()) }
        List = filteredResults
        currentPage = 0
        isSearching = true
    }
    
}
