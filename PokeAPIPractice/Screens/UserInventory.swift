//
//  UserInventory.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 18/02/2025.
//

import SwiftUI

struct UserInventory: View {
    // MARK: - PROPERTIES
    var userVM: UserViewModel
    
    // MARK: - BODY
    var body: some View {
        VStack {
            List(Array(userVM.myPokemonsList), id: \.id) { pokemon in
                Text(pokemon.name)
            }
            .scrollContentBackground(.hidden)
            
            Button(action: {
                userVM.popPokemonFromList()
            }, label: {
                Text("Delete | Development")
            })
            .padding(.bottom, 200)
        }//:VSTACK
        .background(LinearGradient(colors: [.white, Color("DexLight"),Color("DexDark")], startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
    }
}

#Preview {
    UserInventory(userVM: UserViewModel(user: User(name: "name", myPokemons: [Pokemon(name: "Dragapult", id: 2, height: 1, sprites: nil, weight: 1, types: [], abilities: [])])))
}
