//
//  PokemonView.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import SwiftUI

struct PokemonView: View {
    let pokemonVM: PokemonViewModel
    
    var body: some View {
        Text(pokemonVM.name)
            .font(.largeTitle)
        //Text(pokemonVM.height)
        Text("No \(pokemonVM.id)")
        HStack{
            VStack{
                URLImage(url: pokemonVM.spriteNormal)
                Text("Common")
            }
            VStack {
                URLImage(url: pokemonVM.spriteShiny)
                Text("Shiny")
            }
        }
        .frame(width: .infinity, height: 200)
    }
}


