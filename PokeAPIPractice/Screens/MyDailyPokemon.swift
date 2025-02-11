//
//  MyDailyPokemon.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 04/02/2025.
//

import SwiftUI

struct MyDailyPokemon: View {
    // MARK: - PROPERTIES
    
    @ObservedObject private var timeVM = TimeViewModel()
    @ObservedObject private var pokemon = PokemonViewModel()
    private var urlDaily: String {
        return "https://pokeapi.co/api/v2/pokemon/" + String(timeVM.randomDailyNumber)
    }
    init(timeVM: TimeViewModel = TimeViewModel()) {
        self.timeVM = timeVM
    }
    // MARK: - BODY
    var body: some View {
        PokemonCard(pokemon: pokemon)
            .onAppear(perform: {
                pokemon.getPokemonByUrl(url: urlDaily)
            })
    }
}

#Preview {
    MyDailyPokemon()
}
