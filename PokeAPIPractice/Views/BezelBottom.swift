//
//  BezelBottom.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 17/02/2025.
//

import SwiftUI

struct BezelBottom: View {
    // MARK: - PROPERTIES
    @Binding var selectedTab: SelectedTab
    @Binding var path: [String]
    
    
    var body: some View {
        
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
    }
}

#Preview {
    BezelBottom(selectedTab: .constant(.Pokedex), path: .constant([]))
}
