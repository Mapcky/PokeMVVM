//
//  PokemonGridView.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 28/01/2025.
//

import SwiftUI

struct PokemonGridView: View {
    // MARK: - PROPERTIES
    let PokemonLVM: PokemonListViewModel
    private let columnSpacing: CGFloat = 10
    private let rowSpacing: CGFloat = 10
    private var gridLayout: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
    }
    
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
                ForEach(PokemonLVM.pokemonL!.results, id:\.url) { pokemon in
                    GridItemView(urlPokeon: pokemon.url)
                 }
            })//: VGrid
            .padding()
        }//: Scroll
    }
}
/*
#Preview {
    PokemonGridView()
}
*/
