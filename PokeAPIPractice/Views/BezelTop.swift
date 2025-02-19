//
//  BezelTop.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 17/02/2025.
//

import SwiftUI

struct BezelTop: View {
    // MARK: - PROPERTIES
    @Binding var selectedTab: SelectedTab
    @Binding var path: [String]
    
    // MARK: - BODY
    var body: some View {
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
                Button(action: {
                    selectedTab = .Profile
                }) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 40))
                }
            }//: BUTTONS HSTACK
            .foregroundStyle(.black)
            .font(.custom("PressStart2P-Regular", size: 10))
            .padding(.horizontal, 80)
            .padding(.top, 50)
            
        }//: ZSTACK
    }
}

#Preview {
    BezelTop(selectedTab: .constant(.Pokedex), path: .constant([]))
}
