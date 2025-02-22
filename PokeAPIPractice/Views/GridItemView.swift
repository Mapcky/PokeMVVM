//
//  GridItemView.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 28/01/2025.
//

import SwiftUI

struct GridItemView: View {
    // MARK: - PROPERTIES
    @ObservedObject var pokemonVM: PokemonViewModel
    @Binding var path: [String]
    
    // MARK: - BODY
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                URLImage(url: pokemonVM.spriteNormal)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 8, x: 6, y: 8)
                    .padding(3)
                    .background(
                        Image("pokeballSVG2")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.blue)
                            .opacity(0.12))
                
                Text(pokemonVM.id)
                    .font(.custom("PressStart2P-Regular", size: 24))
                    .padding(.horizontal, 8)
                    .padding(.bottom, 3)
                    .foregroundStyle(.black)
                
            }//:ZSTACK
            Text(pokemonVM.name)
                .font(.custom("PressStart2P-Regular", size: 10))
                .foregroundStyle(.black)
                .padding(.vertical, 8)
        }//: VStack
    }
    
}

#Preview {
    GridItemView(pokemonVM: PokemonViewModel(url: "https://pokeapi.co/api/v2/pokemon/700"), path: .constant([]))
}

