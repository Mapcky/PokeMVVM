//
//  GridItemView.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 28/01/2025.
//

import SwiftUI

struct GridItemView: View {
    // MARK: - PROPERTIES
    var urlPokeon: String
    @ObservedObject private var pokemonVM = PokemonViewModel()
    @Binding var path: [String]
    
    init(urlPokeon: String) {
        self.urlPokeon = urlPokeon
        pokemonVM.getPokemonByUrl(url: urlPokeon)
    }
    // MARK: - BODY
    var body: some View {
        NavigationLink(destination: PokemonDetailView(pokemonVM: pokemonVM)) {
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
                    
                }
                Text(pokemonVM.name)
                    .font(.custom("PressStart2P-Regular", size: 10))
                    .foregroundStyle(.black)
                    .padding(.vertical, 8)
                
            }//: VStack
        }//:NAV
        
    }
}

#Preview {
    GridItemView(urlPokeon: "https://pokeapi.co/api/v2/pokemon/700")
}

