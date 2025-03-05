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
    @State private var showConfirmationAlert: Bool = false
    @State private var selectedPokemon: Pokemon?
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
        }//: VSTACK
        .sheet(isPresented: $isPresented, content: {
            ZStack {
                PokemonInventoryGridItem(userVM: userVM, onPokemonSelected: { pokemon in
                    selectedPokemon = pokemon
                    showConfirmationAlert = true
                })
                if showConfirmationAlert {
                    if let selectedPokemon = selectedPokemon, let newPokemon = pokemonVM.pokemon {
                        Color.black.opacity(0.5)
                            .edgesIgnoringSafeArea(.all)
                        VStack(spacing: 20) {
                            Text("Switch \(selectedPokemon.name) for \(newPokemon.name)?")
                                .foregroundColor(.white)
                                .font(.custom("PressStart2P-Regular", size: 18))
                            
                            HStack {
                                Button("Cancelar") {
                                    showConfirmationAlert = false
                                }
                                .padding()
                                .background(Capsule().strokeBorder(Color.white))
                                .foregroundColor(.white)
                                
                                Button("OK") {
                                    userVM.switchPokemon(selectedPokemon: selectedPokemon, newPokemon: newPokemon)
                                    catchActive = false
                                    isPresented = false
                                    showConfirmationAlert = false
                                }
                                .padding()
                                .background(Capsule().strokeBorder(Color.white))
                                .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: 300)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.8)))
                        .shadow(radius: 10)
                    }
                }//: ALERT
            }//: ZSTACK SHEET
        })//: SHEET
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
    }//: BODY
}

#Preview {
    PokemonCard(pokemonVM: PokemonViewModel(url: "https://pokeapi.co/api/v2/pokemon/700"), userVM: UserViewModel(user: User(name: "name", myPokemons: [Pokemon(name: "Dragapult", id: 2, height: 1, sprites: nil, weight: 1, types: [], abilities: [], stats: [])])))
}
