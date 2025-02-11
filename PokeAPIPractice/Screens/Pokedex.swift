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
                    Button(action: {
                    }, label:
                            {Image(systemName: "magnifyingglass")})
                }
                
                .padding()
                
                Text("Pokedex")
                    .font(.title3)
                PokemonGridView(pokemonLVM: pokemonListVM)
            }
            /*
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(Color.red, lineWidth: 14) // Solo borde
                        .frame(height: UIScreen.main.bounds.height * 0.5)
                        .offset(y: -UIScreen.main.bounds.height * 0.27)
                    
                    // Marco blanco inferior
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(Color.white, lineWidth: 20) // Solo borde
                        .frame(height: UIScreen.main.bounds.height * 0.5)
                        .offset(y: UIScreen.main.bounds.height * 0.25)
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: 100)
                }
                    .ignoresSafeArea()
            )
             */
        }
        .navigationTitle("")
    }
    
}


#Preview {
    Pokedex()
}
