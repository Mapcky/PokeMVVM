//
//  Utils.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 01/02/2025.
//

import Foundation
import SwiftUI


// MARK: - Gradient for every type

enum TypeGradient: String {
    case bug, dark, dragon, electric, fairy, fighting, fire, flying, ghost, grass,
         ground, ice, normal, poison, psychic, rock, steel, water

    var gradient: LinearGradient {
        switch self {
        case .bug: return LinearGradient(colors: [.bugLighter, .bug, .bugDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .dark: return LinearGradient(colors: [.darkLighter, .dark, .darkDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .dragon: return LinearGradient(colors: [.dragonLighter, .dragon, .dragonDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .electric: return LinearGradient(colors: [.electricLighter, .electric, .electricDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .fairy: return LinearGradient(colors: [.fairyLighter, .fairy, .fairyDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .fighting: return LinearGradient(colors: [.fightingLighter, .fighting, .fightingDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .fire: return LinearGradient(colors: [.fireLighter, .fire, .fireDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .flying: return LinearGradient(colors: [.flyingLighter, .flying, .flyingDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .ghost: return LinearGradient(colors: [.ghostLighter, .ghost, .ghostDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .grass: return LinearGradient(colors: [.grassLighter, .grass, .grassDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .ground: return LinearGradient(colors: [.groundLighter, .ground, .groundDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .ice: return LinearGradient(colors: [.iceLighter, .ice, .iceDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .normal: return LinearGradient(colors: [.normalLighter, .normal, .normalDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .poison: return LinearGradient(colors: [.poisonLighter, .poison, .poisonDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .psychic: return LinearGradient(colors: [.psychicLighter, .psychic, .psychicDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .rock: return LinearGradient(colors: [.rockLighter, .rock, .rockDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .steel: return LinearGradient(colors: [.steelLighter, .steel, .steelDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .water: return LinearGradient(colors: [.waterLighter, .water, .waterDarker], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    static func from(_ string: String) -> TypeGradient {
        return TypeGradient(rawValue: string.lowercased()) ?? .normal
    }

    static func gradientForType(_ type: String) -> LinearGradient {
        return from(type).gradient
    }
}
