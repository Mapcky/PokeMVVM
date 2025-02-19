//
//  Tabs.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 04/02/2025.
//

import SwiftUI

struct Tabs: View {
    // MARK: - PROPERTIES
    @State private var selectedTab: SelectedTab = .Pokedex
    @State private var path: [String] = []
    @ObservedObject private var pokemonListVM: PokemonListViewModel = PokemonListViewModel()
    @ObservedObject private var timeVM: TimeViewModel = TimeViewModel()
    private var userVM: UserViewModel = UserViewModel()
    // MARK: - BODY
    @MainActor
    @ViewBuilder
    var body: some View {
        VStack {
            // MARK: - TOP DEX
            BezelTop(selectedTab: $selectedTab, path: $path)
            ZStack(alignment: .bottom){
                NavigationStack(path: $path) {
                    VStack {
                        switch selectedTab {
                        case .Pokedex:
                            Pokedex(pokemonListVM: pokemonListVM, path: $path)
                        case .Daily:
                            MyDailyPokemon(timeVM: timeVM, userVM: userVM)
                        case .Profile:
                            UserInventory(userVM: userVM)
                        }//: SWITCH
                    }//: VSTACK
                    .navigationDestination(for: String.self) { url in PokemonDetailView(pokemonVM: PokemonViewModel(url: url))
                    }
                }//:NAV
                BezelBottom(selectedTab: $selectedTab, path: $path)
            }//: ZSTACK
        }//: VSTACK
        .ignoresSafeArea()
        .background(LinearGradient(colors: [.white, Color("DexLight"),Color("DexDark")], startPoint: .topLeading, endPoint: .bottomTrailing))
    }//: BODY
}


// MARK: - Screen Enum

enum SelectedTab {
    case Pokedex
    case Daily
    case Profile
}

#Preview {
    Tabs()
}
