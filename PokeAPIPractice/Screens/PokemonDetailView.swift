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
        VStack{
            switch(pokemonVM.loadingState) {
            case .success:
                PokemonView(pokemonVM: pokemonVM)
                
            case .failed:
                Text("Fail")
            case .loading:
                Text("Loading")
                    .font(.largeTitle)
            case .none:
                Text("none")
            }
        }
    }
}

#Preview
{
    PokemonDetailView(pokemonVM: PokemonViewModel())
}
