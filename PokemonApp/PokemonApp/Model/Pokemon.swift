//
//  Pokemon.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 04..
//

import Foundation

struct Pokemon {
    let id = UUID()
    let name: String
    let type: String
    let weight: Double
    let height: Double
    let abilities: [PokeAbility]
    var isCaught: Bool = false
}

struct PokeAbility {
    let name: String
    let isHiden: Bool
}

