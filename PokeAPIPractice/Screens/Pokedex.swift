//
//  Pokedex.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import SwiftUI

struct Pokedex: View {
    // MARK: - PROPERTIES
    @ObservedObject var pokemonListVM: PokemonListViewModel
    @State private var pokeName: String = ""
    
    // MARK: - Functions
    init() {
        pokemonListVM = PokemonListViewModel()
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack (spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill()
                        .clipShape(BottomSemiCircleShape(cutoutRatio: 6))
                        .frame(height: 160)
                    Rectangle()
                        .fill(.white)
                        .clipShape(BottomSemiCircleShape(cutoutRatio: 4.05))
                        .frame(height: 160)
                    Rectangle()
                        .fill(LinearGradient(colors: [Color("DexTopLight"), Color("DexTop"),Color("DexTop"), Color("DexTopDark")], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(BottomSemiCircleShape(cutoutRatio: 4))
                        .ignoresSafeArea()
                        .frame(height: 160)
                        .overlay(content: {
                            Circle()
                                .stroke(Color.black, lineWidth: 5)
                                .frame(width: 110, height: 110)
                                .position(x: 0, y: 0)
                            Circle()
                                .stroke(Color.black, lineWidth: 5)
                                .frame(width: 200, height: 200)
                                .position(x: 0, y: 0)
                            Circle()
                                .stroke(Color.black, lineWidth: 5)
                                .frame(width: 110, height: 110)
                                .position(x: UIScreen.main.bounds.width, y: 0)
                            Circle()
                                .stroke(Color.black, lineWidth: 5)
                                .frame(width: 200, height: 200)
                                .position(x: UIScreen.main.bounds.width, y: 0)
                        })
                }
                
                    TextField("Search", text: $pokeName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .padding()
                        .onChange(of: pokeName) {
                            pokemonListVM.isSearching = pokeName.isEmpty
                            pokemonListVM.filterByName(search: pokeName)
                        }
                        .padding(.horizontal, 10)
                    
                    Text("Pokedex")
                        .font(.title)
                        .bold()
                    PokemonGridView(pokemonLVM: pokemonListVM)
            }
            .ignoresSafeArea()
            .background(LinearGradient(colors: [.white, Color("DexLight"),Color("DexDark")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay(content: {
                VStack {
                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill()
                            .clipShape(TopSemiCircleShape(cutoutRatio: 6))
                            .frame(height: 110)
                        Rectangle()
                            .fill(.white)
                            .clipShape(TopSemiCircleShape(cutoutRatio: 4.05))
                            .frame(height: 110)
                        Rectangle()
                            .fill(Color("DexTopDark"))
                            .clipShape(TopSemiCircleShape(cutoutRatio: 4))
                            .ignoresSafeArea()
                            .frame(height: 110)
                            .overlay(content: {
                                Circle()
                                    .stroke(Color.black, lineWidth: 5)
                                    .frame(width: 80, height: 110)
                                    .position(x: 0, y: 110)
                                Circle()
                                    .stroke(Color.black, lineWidth: 5)
                                    .frame(width: 150, height: 200)
                                    .position(x: 0, y: 110)
                                Circle()
                                    .stroke(Color.black, lineWidth: 5)
                                    .frame(width: 80, height: 110)
                                    .position(x: UIScreen.main.bounds.width, y: 110)
                                Circle()
                                    .stroke(Color.black, lineWidth: 5)
                                    .frame(width: 150, height: 200)
                                    .position(x: UIScreen.main.bounds.width, y: 110)
                            })
                    }
                    
                    
                }
                .ignoresSafeArea()
            })
        }
        .navigationTitle("")
    }
    
    
}


#Preview {
    Pokedex()
}
