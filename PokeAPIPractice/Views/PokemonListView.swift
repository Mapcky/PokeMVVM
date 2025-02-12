//
//  PokemonList.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 28/01/2025.
//

import SwiftUI

struct PokemonListView: View {
    // MARK: - PROPERTIES
    
    let PokemonLVM: PokemonListViewModel
    
    // MARK: - BODY
    var body: some View {
       List {
           ForEach(PokemonLVM.List, id:\.url) { pokemon in
               Text("\(pokemon.name)")
            }
           
        }
       .listStyle(.plain)
       .frame(height: 300)
    
    }
}

#Preview {
    PokemonListView(PokemonLVM: PokemonListViewModel())
}

