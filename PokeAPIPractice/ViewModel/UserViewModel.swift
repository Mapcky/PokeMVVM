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
    private(set) var user: User?
    
    
    init(user: User? = nil) {
        self.user = User(name: "Ash", myPokemons: [])
        loadUser()
    }
    
    var myPokemonsList: [Pokemon] {
        if let user = user {
            return user.myPokemons
        } else {
            return []
        }
    }
     
    func switchPokemon(selectedPokemon: Pokemon, newPokemon: Pokemon) {
        user?.myPokemons.removeAll { $0 == selectedPokemon }
        user?.myPokemons.append(newPokemon)
        saveUser()
    }
    
    var isInventoryFull: Bool {
        return myPokemonsList.count == 6
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
