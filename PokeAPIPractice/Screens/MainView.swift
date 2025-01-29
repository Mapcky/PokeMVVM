//
//  ContentView.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import SwiftUI

struct MainView: View {
    // MARK: - PROPERTIES
    @ObservedObject var pokemonListVM: PokemonListViewModel
    @State private var pokeName: String = ""
    
    // MARK: - Functions
    init() {
        pokemonListVM = PokemonListViewModel()
        pokemonListVM.getList()
    }
    
    // MARK: - BODY
    var body: some View {
            VStack(spacing: 20) {
                HStack{
                    TextField("Search", text: $pokeName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .padding()
                    Button(action: {

                    }, label:
                            {Image(systemName: "magnifyingglass")})
                }
            }
            .padding()
            Text("Pokedex")
                .font(.title3)
        PokemonGridView(pokemonLVM: pokemonListVM)

        }
}

#Preview {
    MainView()
}
