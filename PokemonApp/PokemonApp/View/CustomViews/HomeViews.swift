//
//  PokeCellText.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 08..
//

import UIKit

// MARK: Searchbar

class PokeSearchBar: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        self.setLeftPadding(5)
    }
    
}

// MARK: Type Selector Title

class PokeSelectorTitle: UILabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupText()
    }
    
    private func setupText() {
        self.textColor = PokeColors.gray
        self.font = UIFont(name: PokeFonts.typeTitle.style, size: PokeFonts.typeTitle.size)
    }
    
}

// MARK: Type Selector

class PokeSelector: UITextField {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupSelector()
    }
    
    private func setupSelector() {
        self.setLeftPadding(5)
        self.layer.borderWidth = 2
        self.layer.borderColor = PokeColors.gray.cgColor
        self.layer.cornerRadius = frame.size.height/6
        self.layer.masksToBounds = true
    }
    
}

// MARK: Checkbox

class PokeCheckBox: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupText()
    }
    
    private func setupText() {
        self.tintColor = PokeColors.gray
    }
    
}

// MARK: Pokemon List Title Background

class PokeListTitleBG: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupBG()
    }
    
    private func setupBG() {
        self.backgroundColor = PokeColors.lightBlue
    }
    
}

// MARK: Pokemon List Title

class PokeListTitle: UILabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupText()
    }
    
    private func setupText() {
        self.textColor = PokeColors.gray
        self.font = UIFont(name: PokeFonts.listTitle.style, size: PokeFonts.listTitle.size)
    }
    
}

// MARK: Pokemon Cell Background

class PokeCellBG: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupCell()
    }
    
    private func setupCell() {
        self.offStyle()
        self.backgroundColor = PokeColors.white
        self.layer.cornerRadius = frame.size.height/6
        self.layer.masksToBounds = true
    }
    
    func onStyle() {
        self.layer.borderWidth = 1
        self.layer.borderColor = PokeColors.yellow.cgColor
    }
    
    func offStyle() {
        self.layer.borderWidth = 1
        self.layer.borderColor = PokeColors.blue.cgColor
    }
    
}

// MARK: Pokemon List Background

class PokeListBG: UITableView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupBG()
    }
    
    private func setupBG() {
        self.backgroundColor = PokeColors.lightBlue
    }
    
}

// MARK: Pokemon Cell Text

class PokeCellText: UILabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupText()
    }
    
    private func setupText() {
        self.textColor = PokeColors.gray
        self.font = UIFont(name: PokeFonts.cellText.style, size: PokeFonts.cellText.size)
    }
    
}

// MARK: Catch Button

class PokeButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupButton()
    }
    
    private func setupButton() {
        self.offStyle()
        self.setTitleColor(PokeColors.white, for: .normal)
        self.setTitleColor(PokeColors.gray, for: .highlighted)
        self.titleLabel?.font = UIFont(name: PokeFonts.button.style, size: PokeFonts.button.size)
        self.layer.cornerRadius = frame.size.height/6
    }
    
    func onStyle() {
        self.setTitle("Release", for: .normal)
        self.backgroundColor = PokeColors.yellow
    }
    
    func offStyle() {
        self.setTitle("Catch", for: .normal)
        self.backgroundColor = PokeColors.blue
    }
    
}
