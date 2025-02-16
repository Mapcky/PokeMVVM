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
    @Environment(\.dismiss) private var dismiss
    // MARK: - FUNCTIONS

    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
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
                .padding(.horizontal, 5)
            Group {
                Text("Height \(pokemonVM.height)")
                Text("Weight \(pokemonVM.weight)")
            }.font(.custom("PressStart2P-Regular", size: 14))
            HStack {
                
                Text(pokemonVM.firstType)
                    .font(.custom("PressStart2P-Regular", size: 12))
                    .foregroundStyle(.white)
                    .shadow(color: .black, radius: 3, x: 0, y: 0.4)
                    .padding(8)
                    .background(Capsule()
                        .fill(TypeGradient.from(pokemonVM.firstType).gradient))
                    
                if pokemonVM.secondType != "" {
                    Text(pokemonVM.secondType)
                        .font(.custom("PressStart2P-Regular", size: 12))
                        .foregroundStyle(.white)
                        .shadow(color: .black, radius: 3, x: 0, y: 0.4)
                        .padding(8)
                        .background(Capsule()
                            .fill(TypeGradient.from(pokemonVM.secondType).gradient))
                }
            }//:HSTACK
            
            ForEach(pokemonVM.abilitiesNames, id:\.self) { ability in
                Text(ability)
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        
        .background(LinearGradient(colors: [.white, Color("DexLight"),Color("DexDark")], startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
    }
    
}

#Preview
{
    PokemonDetailView(pokemonVM: PokemonViewModel(url: "https://pokeapi.co/api/v2/pokemon/700"))
}
