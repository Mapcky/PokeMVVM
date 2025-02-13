//
//  Pokedex.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import SwiftUI

struct Pokedex: View {
    // MARK: - PROPERTIES
    @ObservedObject var pokemonListVM: PokemonListViewModel
    @Binding var path: [String]
    @State private var pokeName: String = ""
    
    // MARK: - Functions
    
    // MARK: - BODY
    var body: some View {
            VStack (spacing: 0) {
                    TextField("Search", text: $pokeName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .padding()
                        .onChange(of: pokeName) {
                            pokemonListVM.isSearching = pokeName.isEmpty
                            pokemonListVM.filterByName(search: pokeName)
                        }
                        .padding(.horizontal, 10)
                    
                    Text("Pokedex")
                        .font(.title)
                        .bold()
                PokemonGridView(pokemonLVM: pokemonListVM, path: $path)
            }
            .ignoresSafeArea()
            .background(LinearGradient(colors: [.white, Color("DexLight"),Color("DexDark")], startPoint: .topLeading, endPoint: .bottomTrailing))
        }
}


#Preview {
    Pokedex(pokemonListVM: PokemonListViewModel(), path: .constant([]))
}
