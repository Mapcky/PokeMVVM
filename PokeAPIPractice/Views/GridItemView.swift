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
    
    init(urlPokeon: String) {
        self.urlPokeon = urlPokeon
        pokemonVM.getPokemonByUrl(url: urlPokeon)
    }
    // MARK: - BODY
    var body: some View {
        VStack {
            switch(pokemonVM.loadingState) {
            case .success:
                ZStack(alignment: .bottomLeading) {
                    URLImage(url: pokemonVM.spriteNormal)
                        .padding(3)
                        .background(Color.white.clipShape(RoundedRectangle(cornerRadius: 12)))
                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                    
                    Text(pokemonVM.id)
                        .font(.custom("PressStart2P-Regular", size: 24))
                        .padding(.horizontal, 8)
                        
                }
                Text(pokemonVM.name)
            case .failed:
                Text("Fail")
            case .loading:
                Text("Loading")
                    .font(.largeTitle)
            case .none:
                Text("none")
            }
        }
    }
}
/*
 #Preview {
 GridItemView()
 }
 */
