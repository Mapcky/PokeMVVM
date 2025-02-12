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
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 15) {
            URLImage(url: pokemon.spriteNormal)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 4, x: 6, y: 8)
            Text(pokemon.name)
                .foregroundColor(Color.white)
                .font(.custom("PressStart2P-Regular", size: 24))
                .fontWeight(.heavy)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 3, x: 2, y: 2)
            Button(action: {
                
            }) {
                HStack (spacing: 8) {
                    Text("Catch!")
                    
                    Image(systemName: "arrow.right.circle")
                        .imageScale(.large)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule().strokeBorder(.white, lineWidth: 1.25)
                )
            }//: BUTTON
            .accentColor(.white)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(TypeGradient.from(pokemon.firstType).gradient)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 20)
    }
}

#Preview {
    PokemonCard()
}
