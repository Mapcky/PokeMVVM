//
//  PokemonView.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import SwiftUI

struct PokemonView: View {
    @ObservedObject var pokemonVM: PokemonViewModel
    
    var body: some View {
        Text(pokemonVM.name)
            .font(.largeTitle)
        Text("No \(pokemonVM.id)")
        Text("Height \(pokemonVM.height)")
        Text("Weight \(pokemonVM.weight)")
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
        //.frame(width: .infinity, height: 200)
    }
}

#Preview
{
    PokemonView(pokemonVM: PokemonViewModel())
}
