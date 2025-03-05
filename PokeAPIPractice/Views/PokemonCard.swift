//
//  pokemonCard.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 31/01/2025.
//

import SwiftUI

struct PokemonCard: View {
    
    // MARK: - PROPERTIES
    @State private var isAnimating: Bool = false
    @ObservedObject var pokemonVM: PokemonViewModel
    var userVM: UserViewModel
    @State private var catchActive: Bool = true
    @State private var isPresented: Bool = false
    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            AsyncImage(url: URL(string: pokemonVM.spriteNormal)) { img in
                img.resizable()
                    .scaledToFit()
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 4, x: 6, y: 8)
            } placeholder: {
                ProgressView("Loading...")
            }
            Text(pokemonVM.name)
                .foregroundColor(Color.white)
                .font(.custom("PressStart2P-Regular", size: 24))
                .fontWeight(.heavy)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 3, x: 2, y: 2)
            Button(action: {
                if !userVM.isInventoryFull {
                    userVM.addPokemon(pokemonVM.pokemon!)
                    catchActive = false
                } else {
                    isPresented.toggle()
                }
            }) {
                HStack (spacing: 8) {
                    Text("Catch!")
                        .font(.custom("PressStart2P-Regular", size: 11))
                    Image(systemName: "arrow.right.circle")
                        .imageScale(.large)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule().strokeBorder(.white, style: StrokeStyle(lineWidth: 1.25,dash: [25, 5]))
                )
                .foregroundStyle(catchActive ? .white : .black)
            }//: BUTTON
            .disabled(!catchActive)
            /*
            Button("pop"){
                userVM.popPokemonFromList()
            }
             */
        }
        .sheet(isPresented: $isPresented, content: {
            PokemonInventoryGridItem(userVM: userVM, onPokemonSelected: { pokemon in
                guard let newPokemon = pokemonVM.pokemon else { return }
                userVM.switchPokemon(selectedPokemon: pokemon, newPokemon: newPokemon)
                catchActive = false
            })
        })
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .onChange(of: pokemonVM.pokemon, {
            if let pokemon = pokemonVM.pokemon {
                catchActive = !userVM.pokemonOwned(pokemon)
            }
        })
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 600, alignment: .center)
        .background(TypeGradient.from(pokemonVM.firstType).gradient)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 20)
    }
}

#Preview {
    PokemonCard(pokemonVM: PokemonViewModel(url: "https://pokeapi.co/api/v2/pokemon/700"), userVM: UserViewModel(user: User(name: "name", myPokemons: [Pokemon(name: "Dragapult", id: 2, height: 1, sprites: nil, weight: 1, types: [], abilities: [], stats: [])])))
}
