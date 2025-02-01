//
//  PokemonListViewModel.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 28/01/2025.
//

import Foundation

class PokemonListViewModel: ViewModelBase {

    // MARK: - PROPERTIES
    @Published var pokemonL: PokemonList?
    @Published var List: [results] = []
    @Published var currentPage: Int = 0
    var isSearching: Bool = false
    let webService = WebService()
    
    private let pageSize: Int = 50
    private var isLoading: Bool = false
    
    
    // MARK: - FUNCTIONS
    init(pokemonL: PokemonList? = nil) {
        self.pokemonL = pokemonL
    }
        
    var count: Int {
        pokemonL?.count ?? 0
    }

    func getFullList() {
        self.loadingState = .loading
        webService.getPokemonList(limit: 100000, offset: 0) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.pokemonL = data
                    self.loadNextPage()
                    self.currentPage += 1
                    self.loadingState = .success
                case .failure(let error):
                    print(error.localizedDescription)
                    self.loadingState = .failed
                }
            }
        }
    }
    
    func loadNextPage() {
        if !isSearching {
            guard currentPage * pageSize < pokemonL?.results.count ?? 0 else { return }
            let startIndex = currentPage * pageSize
            let endIndex = min(startIndex + pageSize, pokemonL?.results.count ?? 0)
            let newPokemon = Array(pokemonL!.results[startIndex..<endIndex])
            
            DispatchQueue.main.async {
                self.List.append(contentsOf: newPokemon)
                self.currentPage += 1
            }
        }
    }
    
    
    func getListWithPaging() {
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
                }//: switch
            }//: DispatchQ
        }//: Webservice
    }
    
    func filterByName(search: String) {
        let filteredResults = pokemonL!.results.filter{ $0.name.hasPrefix(search.lowercased()) }
        List = filteredResults
        currentPage = 0
        isSearching = true
    }
    
    
}
