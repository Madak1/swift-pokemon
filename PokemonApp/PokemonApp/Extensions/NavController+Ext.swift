//
//  NavController+Ext.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 08..
//

import UIKit

extension UINavigationController {
    
    func setNavBarColor(bgColor: UIColor, fgColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = bgColor
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : fgColor]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : fgColor]
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        
        self.navigationBar.tintColor = fgColor
        UIBarButtonItem.appearance().tintColor = fgColor
    }
    
}

