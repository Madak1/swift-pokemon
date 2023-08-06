//
//  PokemonCell.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 05..
//

import UIKit

class PokemonCell: UITableViewCell {
    
    
    @IBOutlet var name: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var catchBtn: UIButton!
    
    weak var delegate: StatusChangerDelegate?
    
    var pokemon: Pokemon?
    
    func setPokemon(pokemon: Pokemon) {
        self.pokemon = pokemon
        name.text = pokemon.name
        type.text = pokemon.type
        status.text = pokemon.isCaught ? "Caught" : "-"
        catchBtn.setTitle(pokemon.isCaught ? "R" : "C", for: .normal)
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
