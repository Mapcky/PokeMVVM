//
//  PokemonInventoryGridItem.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 19/02/2025.
//

import SwiftUI

struct PokemonInventoryGridItem: View {
    // MARK: - PROPERTIES
    var userVM: UserViewModel
    var onPokemonSelected: (Pokemon) -> Void
    @Environment(\.dismiss) private var dismiss
    private let columnSpacing: CGFloat = 10
    private let rowSpacing: CGFloat = 10
    private var gridLayout: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
    }
    // MARK: - BODY
    var body: some View {
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
            ForEach(userVM.myPokemonsList, id:\.id) { pokemon in
                VStack(alignment: .center, spacing: 15) {
                    AsyncImage(url: URL(string: pokemon.sprites!.front_default)) { img in
                        img.resizable()
                            .scaledToFit()
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 4, x: 6, y: 8)
                    } placeholder: {
                        ProgressView("Locading...")
                    }
                    Text(pokemon.name)
                        .foregroundColor(Color.white)
                        .font(.custom("PressStart2P-Regular", size: 12))
                        .fontWeight(.heavy)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 3, x: 2, y: 2)
                        .padding(.vertical, 10)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200, alignment: .center)
                .background(TypeGradient.from(pokemon.types[0].type.name).gradient)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 20)
                .onTapGesture {
                    onPokemonSelected(pokemon)
                    dismiss()
                }
            }//:Loop
        })//: VGrid
        .background(.clear)
        .padding()
    }
}

#Preview {
    PokemonInventoryGridItem(userVM: UserViewModel(), onPokemonSelected: { pokemon in
    })
}
