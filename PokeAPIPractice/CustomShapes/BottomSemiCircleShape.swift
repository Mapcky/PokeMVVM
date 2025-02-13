//
//  BottomSemiCircleShape.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 12/02/2025.
//

import SwiftUI

struct BottomSemiCircleShape: Shape {
    var cutoutRatio: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radius = rect.width / cutoutRatio // Tamaño del semicírculo
        let center = CGPoint(x: rect.midX, y: rect.maxY) // Centro del recorte

        // Mueve el cursor al punto inicial (esquina superior izquierda)
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        // Dibuja la línea superior
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        // Dibuja el lado derecho
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        // Dibuja hasta el inicio del semicírculo
        path.addLine(to: CGPoint(x: center.x + radius, y: rect.maxY))
        // Dibuja el arco del semicírculo (recorte)
        path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .degrees(180), clockwise: true)
        // Dibuja el lado izquierdo
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        // Cierra el path
        path.closeSubpath()
        
        return path
    }
}
