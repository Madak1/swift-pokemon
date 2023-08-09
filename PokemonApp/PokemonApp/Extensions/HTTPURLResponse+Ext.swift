//
//  HTTPURLResponse+Ext.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 08..
//

import Foundation

extension HTTPURLResponse {
    var isSuccessful: Bool {
        return (200...299).contains(statusCode)
    }
}

