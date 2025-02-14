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
    
    // MARK: - FUNCTIONS
    init(timeVM: TimeViewModel, pokemonVM: PokemonViewModel? = nil) {
        self.timeVM = timeVM
        var urlDaily: String {
            return "https://pokeapi.co/api/v2/pokemon/" + String(timeVM.randomDailyNumber)
        }
        self.pokemonVM = PokemonViewModel(url: urlDaily)
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            PokemonCard(pokemonVM: pokemonVM)
                .offset(y:-40)
            Spacer()
        }
        .background(LinearGradient(colors: [.white, Color("DexLight"),Color("DexDark")], startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
    }
}


 #Preview {
     MyDailyPokemon(timeVM: TimeViewModel())
 }
 
