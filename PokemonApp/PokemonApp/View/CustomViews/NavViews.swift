//
//  PokeBar.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 08..
//

import UIKit

// MARK: Navigation Controller

class PokeNavController: UINavigationController {
    
    required override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.setupBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupBar()
    }
    
    private func setupBar() {
        // Set the NavigationBar background color to red and the foreground color to white
        self.setNavBarColor(bgColor: PokeColors.darkRed, fgColor: PokeColors.white)
    }
    
}

// MARK: Navigation Item

class PokeNavItem: UINavigationItem {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupNavItem()
    }
    
    private func setupNavItem() {
        // Set the Pokemon Logo as a NavigationBar Title
        self.titleView = UIImageView(image: UIImage(named: "PokeLogo"))
    }
    
}

