//
//  ContentView.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var pokemonVM: PokemonViewModel
    @State private var pokeName: String = ""
    
    init() {
        pokemonVM = PokemonViewModel()
        pokemonVM.getPokemon(name: "sylveon")
    }
    
    var body: some View {
        NavigationView() {
            ScrollView {
                
                VStack(spacing: 40) {
                    HStack{
                        TextField("Search", text: $pokeName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Button(action: {
                            pokemonVM.getPokemon(name: pokeName
                            )}, label:
                                {Image(systemName: "magnifyingglass")})
                    }
                    switch(pokemonVM.loadingState) {
                    case .success:
                        PokemonView(pokemonVM: pokemonVM)
                    case .failed:
                        Text("Fail")
                    case .loading:
                        Text("Loading")
                            .font(.largeTitle)
                    case .none:
                        Text("none")
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    MainView()
}
