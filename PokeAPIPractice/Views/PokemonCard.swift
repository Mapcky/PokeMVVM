//
//  pokemonCard.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 31/01/2025.
//

import SwiftUI

struct PokemonCard: View {
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack {
            URLImage(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/700.png")
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.35), radius: 8, x: 6, y: 8)
            Text("Sylveon")
                .foregroundColor(Color.white)
                .font(.custom("PressStart2P-Regular", size: 24))
                .fontWeight(.heavy)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 2, x: 2, y: 2)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(colors: [.fairy, .fairyLight], startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 20)
    }
}

#Preview {
    PokemonCard()
}
