//
//  PokemonDetailView.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 28/01/2025.
//

import SwiftUI

struct PokemonDetailView: View {
    // MARK: - PROPERTIES
    
    var pokemonVM: PokemonViewModel
    @Environment(\.dismiss) private var dismiss
    // MARK: - FUNCTIONS
    
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                Text(pokemonVM.name)
                    .font(.custom("PressStart2P-Regular", size: 22))
                    .offset()
                Text("No \(pokemonVM.id)")
                    .font(.custom("PressStart2P-Regular", size: 18))
                
                TabView {
                    VStack {
                        URLImage(url: pokemonVM.spriteNormal)
                        Text("Common Form")
                    }
                    VStack {
                        URLImage(url: pokemonVM.spriteShiny)
                        Text("Shiny Form")
                    }
                }//: TAB
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .font(.custom("PressStart2P-Regular", size: 16))
                .frame(height: 300)
                .padding()
                
                Group {
                    Text("Height \(pokemonVM.height)")
                    Text("Weight \(pokemonVM.weight)")
                }.font(.custom("PressStart2P-Regular", size: 14))
                Divider()
                // MARK: - TYPES
                Text("Types")
                    .font(.custom("PressStart2P-Regular", size: 16))
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
                Divider()
                
                // MARK: - ABILITIES
                Text("Abilities")
                    .font(.custom("PressStart2P-Regular", size: 16))
                HStack(spacing: 30) {
                    ForEach(pokemonVM.abilities, id:\.self) { abilities in
                        VStack(spacing: 10) {
                            Text(abilities.ability.name.firstUppercased)
                            if abilities.is_hidden {
                                Text("Hidden ability")
                                    .font(.custom("PressStart2P-Regular", size: 10))
                            }
                        }
                    }
                }//: LOOP
                .font(.custom("PressStart2P-Regular", size: 12))
                Divider()
                // MARK: - STATS
                if let pokemon = pokemonVM.pokemon {
                    StatBar(title: pokemon.stats[0].stat.name, statValue: pokemon.stats[0].baseStat)
                    StatBar(title: pokemon.stats[1].stat.name, statValue: pokemon.stats[1].baseStat)
                    StatBar(title: pokemon.stats[2].stat.name, statValue: pokemon.stats[2].baseStat)
                    StatBar(title: pokemon.stats[3].stat.name, statValue: pokemon.stats[3].baseStat)
                    StatBar(title: pokemon.stats[4].stat.name, statValue: pokemon.stats[4].baseStat)
                    StatBar(title: pokemon.stats[5].stat.name, statValue: pokemon.stats[5].baseStat)
                }
                Color.clear.frame(height: 120)
            }//:VSTACK
        }//: SCROLL
        .navigationBarBackButtonHidden(true)
        .background(LinearGradient(colors: [.white, Color("DexLight"),Color("DexDark")], startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
    }
}

#Preview
{
    PokemonDetailView(pokemonVM: PokemonViewModel(url: "https://pokeapi.co/api/v2/pokemon/700"))
}
