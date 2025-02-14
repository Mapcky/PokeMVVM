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
        VStack(spacing: 15) {
            Text(pokemonVM.name)
                .font(.custom("PressStart2P-Regular", size: 22))
            Text("No \(pokemonVM.id)")
                .font(.custom("PressStart2P-Regular", size: 18))
            
            HStack{
                VStack{
                    URLImage(url: pokemonVM.spriteNormal)
                    Text("Common")
                }
                VStack {
                    URLImage(url: pokemonVM.spriteShiny)
                    Text("Shiny")
                }
            }.font(.custom("PressStart2P-Regular", size: 16))
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).stroke(.gray, lineWidth: 4))
            Group {
                Text("Height \(pokemonVM.height)")
                Text("Weight \(pokemonVM.weight)")
            }.font(.custom("PressStart2P-Regular", size: 14))
        }
    }
}

#Preview
{
    PokemonView(pokemonVM: PokemonViewModel(url: ""))
}
