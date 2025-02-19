//
//  MyDailyPokemon.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 04/02/2025.
//

import SwiftUI

struct MyDailyPokemon: View {
    // MARK: - PROPERTIES
    
    @ObservedObject var timeVM : TimeViewModel
    @ObservedObject private var pokemonVM: PokemonViewModel
    var userVM: UserViewModel
    
    // MARK: - FUNCTIONS
    init(timeVM: TimeViewModel, pokemonVM: PokemonViewModel? = nil, userVM: UserViewModel) {
        self.timeVM = timeVM
        var urlDaily: String {
            return "https://pokeapi.co/api/v2/pokemon/" + String(timeVM.randomDailyNumber)
        }
        self.pokemonVM = PokemonViewModel(url: urlDaily)
        self.userVM = userVM
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            PokemonCard(pokemonVM: pokemonVM, userVM: userVM, maxHeight: 600)
                .offset(y:-40)
            Spacer()
        }
        .background(LinearGradient(colors: [.white, Color("DexLight"),Color("DexDark")], startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
        .task(id: timeVM.randomDailyNumber, {
            let newUrl = "https://pokeapi.co/api/v2/pokemon/\(timeVM.randomDailyNumber)"
            pokemonVM.getPokemonByUrl(url: newUrl)
        })
    }
}


 #Preview {
     MyDailyPokemon(timeVM: TimeViewModel(), userVM: UserViewModel(user: User(name: "name", myPokemons: [Pokemon(name: "Dragapult", id: 2, height: 1, sprites: nil, weight: 1, types: [], abilities: [])])))
 }
 
