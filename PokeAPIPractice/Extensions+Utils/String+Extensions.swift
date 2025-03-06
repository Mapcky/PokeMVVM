//
//  String+Extensions.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 06/03/2025.
//

import Foundation

extension String {
    
    var firstUppercased: String {
        guard let first = self.first else { return self }
        return first.uppercased() + self.dropFirst()
    }
}
