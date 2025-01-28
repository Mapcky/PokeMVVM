//
//  ContentView.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var pokemonVM: PokemonViewModel
    @ObservedObject var pokemonListVM: PokemonListViewModel
    @State private var pokeName: String = ""
    
    init() {
        pokemonVM = PokemonViewModel()
        pokemonListVM = PokemonListViewModel()
        pokemonVM.getPokemon(name: "sylveon")
        pokemonListVM.getList()
    }
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 20) {
                HStack{
                    TextField("Search", text: $pokeName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button(action: {
                        pokemonVM.getPokemon(name: pokeName
                        )
                    }, label:
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
            Text("Pokedex")
                .font(.title3)
            switch(pokemonListVM.loadingState) {
            case .success:
                PokemonListView(PokemonLVM: pokemonListVM)
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

#Preview {
    MainView()
}
