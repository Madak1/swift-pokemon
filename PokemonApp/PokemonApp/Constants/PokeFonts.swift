//
//  PokeFonts.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 08..
//

import Foundation

struct PokeFonts {
    static let typeTitle = PokeFont(style: "Helvetica-Bold", size: 13)
    static let checkBoxText = PokeFont(style: "Helvetica", size: 13)
    static let listTitle = PokeFont(style: "Helvetica-Bold", size: 12)
    static let cellText = PokeFont(style: "Helvetica", size: 12)
    static let detail = PokeFont(style: "Helvetica", size: 21)
    static let detailBold = PokeFont(style: "Helvetica-Bold", size: 21)
    static let button = PokeFont(style: "Helvetica", size: 13)
}

struct PokeFont {
    let style: String
    let size: CGFloat
}

