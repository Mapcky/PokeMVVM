//
//  StatBar.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 05/03/2025.
//

import SwiftUI

struct StatBar: View {
    var title: String
    var statValue: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.firstUppercased)
                .font(.custom("PressStart2P-Regular", size: 14))
                .foregroundColor(.black)
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 10) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: geometry.size.width, height: 10) .foregroundColor(Color.gray.opacity(0.3))
                            .cornerRadius(5)
                        
                        Rectangle()
                            .frame(width: CGFloat(statValue) / 255 * geometry.size.width, height: 10)
                            .foregroundColor(.cyan)
                            .cornerRadius(5)
                            .animation(.easeOut(duration: 1), value: statValue)
                    }
                    HStack() {
                        Spacer()
                        Text(String(statValue))
                            .font(.custom("PressStart2P-Regular", size: 14))
                        Spacer()
                    }//HSTACK
                }//:VSTACK
            }//:Geometry
        }//:VSTACK
        .padding(.horizontal, 10)
        .padding(.vertical, 15)

    }
}

#Preview {
    StatBar(title: "Hp", statValue: 127)
}
