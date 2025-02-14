//
//  Tabs.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 04/02/2025.
//

import SwiftUI

struct Tabs: View {
    // MARK: - PROPERTIES
    @State private var selectedTab: selectedTab = .Pokedex
    @State private var path: [String] = []
    @ObservedObject private var pokemonListVM: PokemonListViewModel = PokemonListViewModel()
    @ObservedObject private var TimeVM: TimeViewModel = TimeViewModel()
    // MARK: - BODY
    var body: some View {
            VStack {
                // MARK: - TOP DEX
                ZStack {
                    Rectangle()
                        .fill()
                        .clipShape(BottomSemiCircleShape(cutoutRatio: 8))
                        .frame(height: 120)
                    Rectangle()
                        .fill(.white)
                        .clipShape(BottomSemiCircleShape(cutoutRatio: 6.05))
                        .frame(height: 120)
                    Rectangle()
                        .fill(LinearGradient(colors: [Color("DexTopLight"), Color("DexTop"),Color("DexTop"), Color("DexTopDark")], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(BottomSemiCircleShape(cutoutRatio: 6))
                        .ignoresSafeArea()
                        .frame(height: 120)
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
                        })//: OVERLAY TOP
                    HStack {
                        if !path.isEmpty {
                            Button(action: {
                                path.removeLast()
                            }) {
                                Image(systemName: "arrow.backward.circle")
                                    .font(.system(size: 40))
                            }
                       }
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 40))
                        }
                    }//: BUTTONS HSTACK
                    .foregroundStyle(.black)
                    .font(.custom("PressStart2P-Regular", size: 10))
                    .padding(.horizontal, 80)
                    .padding(.top, 50)
                    
                }//: ZSTACK
                ZStack(alignment: .bottom){
                    NavigationStack(path: $path) {
                        
                        switch selectedTab {
                        case .Pokedex:
                            Pokedex(pokemonListVM: pokemonListVM, path: $path)
                        case .Daily:
                            MyDailyPokemon(timeVM: TimeVM)
                        case .Profile:
                            EmptyView()
                        }//: SWITCH
                        
                    }
                    
                    
                    Rectangle()
                        .fill()
                        .clipShape(TopSemiCircleShape(cutoutRatio: 8))
                        .frame(height: 80)
                    Rectangle()
                        .fill(.white)
                        .clipShape(TopSemiCircleShape(cutoutRatio: 6.05))
                        .frame(height: 80)
                    Rectangle()
                        .fill(LinearGradient(colors: [Color("DexTop"), Color("DexTopDark"),Color("DexTopDark")], startPoint: .bottomLeading, endPoint: .bottomTrailing))
                        .clipShape(TopSemiCircleShape(cutoutRatio: 6))
                        .ignoresSafeArea()
                        .frame(height: 80)
                    
                        .overlay(content: {
                            Circle()
                                .stroke(Color.black, lineWidth: 5)
                                .frame(width: 80, height: 80)
                                .position(x: 0, y: 90)
                            Circle()
                                .stroke(Color.black, lineWidth: 5)
                                .frame(width: 130, height: 130)
                                .position(x: 0, y: 90)
                            Circle()
                                .stroke(Color.black, lineWidth: 5)
                                .frame(width: 80, height: 80)
                                .position(x: UIScreen.main.bounds.width, y: 90)
                            Circle()
                                .stroke(Color.black, lineWidth: 5)
                                .frame(width: 130, height: 130)
                                .position(x: UIScreen.main.bounds.width, y: 90)
                        })//: OVERLAY
                     HStack {
                        Button(action: {
                            self.selectedTab = .Pokedex
                            path.removeAll()
                        }, label: {
                            VStack(spacing: 5) {
                                Image("Pokedex")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                Text("Pokedex")
                            }
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            self.selectedTab = .Daily
                            path.removeAll()
                        }, label: {
                            VStack(spacing: 5) {
                                Image("pokeballSVG")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                Text("Daily")
                            }
                        })
                    }//: BUTTONS BOT HSTACK
                    .foregroundStyle(.black)
                    .font(.custom("PressStart2P-Regular", size: 10))
                    .padding(.horizontal, 75)
                    .padding(.bottom, 18)
                }//: ZSTACK
            }//: VSTACK
            .ignoresSafeArea()
            .background(LinearGradient(colors: [.white, Color("DexLight"),Color("DexDark")], startPoint: .topLeading, endPoint: .bottomTrailing))
    }//: BODY
}


// MARK: - Screen Enum

enum selectedTab {
    case Pokedex
    case Daily
    case Profile
}

#Preview {
    Tabs()
}
