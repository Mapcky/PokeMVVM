//
//  Tabs.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 04/02/2025.
//

import SwiftUI

struct Tabs: View {
    var body: some View {
        TabView {
            Tab("Pokedexs", systemImage: "compass.drawing") {
                Pokedex()
            }
            
            Tab("Daily Pokemon", systemImage: "sun.horizon") {
                MyDailyPokemon()
            }
        }
    }
}

#Preview {
    Tabs()
}
