//
//  PokemonGridViewWPaging.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 29/01/2025.
//

import SwiftUI

struct PokemonGridViewWPaging: View {
    // MARK: - PROPERTIES
    @ObservedObject var pokemonLVM: PokemonListViewModel
    private let columnSpacing: CGFloat = 10
    private let rowSpacing: CGFloat = 10
    private var gridLayout: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 3)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
                if let pokemonResults = pokemonLVM.pokemonL?.results {
                    ForEach(pokemonResults, id:\.url) { pokemon in
                        GridItemView(urlPokeon: pokemon.url)
                            .onAppear {
                                if pokemon == pokemonResults.last {
                                    pokemonLVM.getListWithPaging()
                                }
                            }
                    }
                }
            })//: VGrid
            .padding()
        }//: Scroll
        .onAppear {
            if pokemonLVM.List.isEmpty {
                pokemonLVM.getListWithPaging()
            }
        }
    }
}


#Preview {
    PokemonGridViewWPaging(pokemonLVM: PokemonListViewModel())
}
