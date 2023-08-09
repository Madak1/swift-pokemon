//
//  PokeImage.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 08..
//

import UIKit

// MARK: Pokemon Image

class PokeImage: UIImageView {
    
    func onStyle() {
        self.layer.borderWidth = 5
        self.layer.borderColor = PokeColors.yellow.cgColor
    }
    
    func offStyle() {
        self.layer.borderWidth = 0
        self.layer.borderColor = PokeColors.white.cgColor
    }
    
}

// MARK: Pokemon Image Spinner

class PokeSpinner: UIActivityIndicatorView {
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.setupSpinner()
    }
    
    func setupSpinner() {
        self.style = .large
        self.color = .gray
        self.hidesWhenStopped = true
        self.onStyle()
    }
    
    func onStyle() {
        self.startAnimating()
    }
    
    func offStyle() {
        self.stopAnimating()
    }
    
}

// MARK: Pokemon Detail Row Background

class PokeRow: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupRow()
    }
    
    private func setupRow() {
        if self.tag == 0 {
            self.backgroundColor = PokeColors.oddRow
        } else {
            self.backgroundColor = PokeColors.evenRow
        }
    }
    
}

// MARK: Pokemon Detail Row Text

class PokeDetailText: UILabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupText()
    }
    
    private func setupText() {
        self.textColor = PokeColors.detailText
        if self.tag == 0 {
            self.font = UIFont(name: PokeFonts.helvetica, size: 21)
        } else {
            self.text = ""
            self.font = UIFont(name: PokeFonts.helveticaBold, size: 21)
        }
    }

}

// MARK: Catch Button

// Implementation in HomeViews.swift

