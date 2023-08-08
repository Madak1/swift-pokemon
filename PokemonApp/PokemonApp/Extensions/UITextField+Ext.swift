//
//  UITextField+Ext.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 08..
//

import UIKit

extension UITextField {
    func setLeftPadding(_ points: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: points, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

