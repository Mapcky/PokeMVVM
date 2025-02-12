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
    @State private var pokeName: String = ""
    
    // MARK: - Functions
    init() {
        pokemonListVM = PokemonListViewModel()
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack{
                    TextField("Search", text: $pokeName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .padding()
                        .onChange(of: pokeName) {
                            pokemonListVM.isSearching = pokeName.isEmpty
                            pokemonListVM.filterByName(search: pokeName)
                        }
                }
                
                .padding()
                
                Text("Pokedex")
                    .font(.title3)
                PokemonGridView(pokemonLVM: pokemonListVM)
            }
            .background(LinearGradient(colors: [.white, Color("DexLight"),Color("DexDark")], startPoint: .topLeading, endPoint: .bottomTrailing))
        }
        .navigationTitle("")
    }
    
}


#Preview {
    Pokedex()
}
