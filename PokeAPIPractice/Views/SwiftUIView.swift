//
//  SwiftUIView.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 28/01/2025.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        List{
            ForEach(1...10, id:\.self) {numero in
                Text(String(numero))
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
