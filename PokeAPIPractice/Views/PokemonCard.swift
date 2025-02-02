//
//  pokemonCard.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 31/01/2025.
//

import SwiftUI

struct PokemonCard: View {
    
    // MARK: - PROPERTIES
    @State private var isAnimating: Bool = false
    @ObservedObject var pokemon = PokemonViewModel()

    // MARK: - FUNCTIONS
    
    func gradientForType(type: String) -> LinearGradient {
        let gradients: [String: LinearGradient] = [
            "bug": bugGradient,
            "dark": darkGradient,
            "dragon": dragonGradient,
            "electric": electricGradient,
            "fairy": fairyGradient,
            "fighting": fightingGradient,
            "fire": fireGradient,
            "flying": flyingGradient,
            "ghost": ghostGradient,
            "grass": grassGradient,
            "ground": groundGradient,
            "ice": iceGradient,
            "normal": normalGradient,
            "poison": poisonGradient,
            "psychic": psychicGradient,
            "rock": rockGradient,
            "steel": steelGradient,
            "water": waterGradient
        ]

        return gradients[type.lowercased()] ?? normalGradient
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            URLImage(url: pokemon.spriteNormal)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 4, x: 6, y: 8)
            Text(pokemon.name)
                .foregroundColor(Color.white)
                .font(.custom("PressStart2P-Regular", size: 24))
                .fontWeight(.heavy)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 3, x: 2, y: 2)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(gradientForType(type: pokemon.firstType))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 20)
    }
}

#Preview {
    PokemonCard()
}
