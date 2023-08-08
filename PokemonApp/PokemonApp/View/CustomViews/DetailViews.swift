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

// MARK: Pokemon Row Background

class PokeRow: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupRow()
    }
    
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

// MARK: Pokemon Row Text

class PokeDetailText: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupText()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupText()
    }
    
    private func setupText() {
        self.textColor = PokeColors.detailText
        if self.tag == 0 {
            self.font = UIFont(name: PokeFonts.detail.style, size: PokeFonts.detail.size)
        } else {
            self.text = ""
            self.font = UIFont(name: PokeFonts.detailBold.style, size: PokeFonts.detailBold.size)
        }
    }

}

// MARK: Catch Button

// Implementation in HomeViews.swift

