//
//  PokemonCell.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 05..
//

import UIKit

class PokeCell: UITableViewCell {
    
    static let identifier = "PokeCell"
    
    @IBOutlet var name: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var catchBtn: UIButton!
    
    weak var delegate: CatchBtnDelegate?
    
    private var pokemon: Pokemon!
    
    func configure(with pokemon: Pokemon) {
        self.pokemon = pokemon
        self.name.text = pokemon.name
        self.type.text = pokemon.types.joined(separator: ", ")
        self.status.text = pokemon.isCaught ? "Caught" : "-"
        self.catchBtn.setTitle(pokemon.isCaught ? "R" : "C", for: .normal)
    }

    @IBAction func catchBtnTapped(_ sender: UIButton) {
        pokemon?.isCaught.toggle()
        if let poke = pokemon {
            delegate?.didChangeStatusValue(id: poke.id, newValue: poke.isCaught)
            status.text = poke.isCaught ? "Caught" : "-"
            catchBtn.setTitle(poke.isCaught ? "R" : "C", for: .normal)
        }
    }
}
