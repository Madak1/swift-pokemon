//
//  UIColor+Ext.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 04..
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

