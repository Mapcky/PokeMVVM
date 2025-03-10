//
//  UserViewModel.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 17/02/2025.
//

import Foundation
import Observation

@MainActor
@Observable
class UserViewModel {
    // MARK: - PROPERTIES
    private(set) var user: User?
    
    var myPokemonsList: [Pokemon] {
        if let user = user {
            return user.myPokemons
        } else {
            return []
        }
    }
    
    var isInventoryFull: Bool {
        return myPokemonsList.count == 6
    }

    // MARK: - FUNCTIONS
    init(user: User? = nil) {
        self.user = User(name: "Ash", myPokemons: [])
        loadUser()
    }
     
    func swapPokemon(selectedPokemon: Pokemon, newPokemon: Pokemon) {
        if let index = user?.myPokemons.firstIndex(of: selectedPokemon) {
            user?.myPokemons[index] = newPokemon
        }
        saveUser()
    }

    
    func addPokemon(_ pokemon: Pokemon) {
        user?.myPokemons.append(pokemon)
        saveUser()
    }
    
    func pokemonOwned(_ pokemon: Pokemon ) -> Bool {
        return user!.myPokemons.contains(where: { $0.id == pokemon.id })
    }
    
    private func saveUser() {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "myUser")
        }
    }
    

    private func loadUser() {
        if let savedData = UserDefaults.standard.data(forKey: "myUser"),
           let decodedUser = try? JSONDecoder().decode(User.self, from: savedData) {
            self.user = decodedUser
        }
    }
}
