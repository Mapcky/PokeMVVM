//
//  PokemonDetailView.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 28/01/2025.
//

import SwiftUI

struct PokemonDetailView: View {
    // MARK: - PROPERTIES
    
    @ObservedObject var pokemonVM: PokemonViewModel
    
    // MARK: - FUNCTIONS

    
    // MARK: - BODY
    var body: some View {
            PokemonView(pokemonVM: pokemonVM)
    }
}

#Preview
{
    PokemonDetailView(pokemonVM: PokemonViewModel())
}
