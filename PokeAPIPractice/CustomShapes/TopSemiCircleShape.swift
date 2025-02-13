//
//  TopSemiCircleShape.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 12/02/2025.
//

import SwiftUI

struct TopSemiCircleShape: Shape {
    var cutoutRatio: CGFloat // Relación del tamaño del recorte respecto al ancho

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radius = rect.width / cutoutRatio // Controla el tamaño del recorte
        let center = CGPoint(x: rect.midX, y: rect.minY) // Centro del recorte en la parte superior

        // Dibuja el rectángulo con un recorte semicircular en la parte superior
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: center.x - radius, y: rect.minY))
        path.addArc(center: center, radius: radius, startAngle: .degrees(180), endAngle: .zero, clockwise: true)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}
