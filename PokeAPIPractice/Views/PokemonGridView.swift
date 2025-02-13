//
//  PokemonGridView.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 28/01/2025.
//

import SwiftUI

struct PokemonGridView: View {
    // MARK: - PROPERTIES
    @ObservedObject var pokemonLVM: PokemonListViewModel
    @Binding var path: [String]
    private let columnSpacing: CGFloat = 10
    private let rowSpacing: CGFloat = 10
    private var gridLayout: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 3)
    }
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
                ForEach(pokemonLVM.List, id:\.url) { pokemon in
                    GridItemView(pokemonVM: PokemonViewModel, path: $path)
                        .onAppear {
                            if pokemon == pokemonLVM.List.last {
                                pokemonLVM.loadNextPage()
                                
                            }
                        }
                 }
            })//: VGrid
            .padding()
        }//: Scroll
        .onAppear {
            if pokemonLVM.List.isEmpty {
                pokemonLVM.getFullList()
            }
        }
    }
}

#Preview {
    PokemonGridView(pokemonLVM: PokemonListViewModel(), path: .constant([]))
}

