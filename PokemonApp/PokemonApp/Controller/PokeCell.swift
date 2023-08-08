//
//  PokemonCell.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 05..
//

import UIKit

class PokeCell: UITableViewCell {
    
    static let identifier = "PokeCell"
    
    @IBOutlet var cell: PokeCellBG!
    @IBOutlet var name: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var catchBtn: PokeButton!
    
    weak var delegate: CatchBtnDelegate?
    
    private var pokemon: Pokemon!
    
    func configure(with pokemon: Pokemon) {
        self.pokemon = pokemon
        self.name.text = pokemon.name.capitalized
        self.type.text = pokemon.types.joined(separator: ", ").capitalized
        self.status.text = pokemon.isCaught ? "Caught" : "-"
        self.pokemon.isCaught ? catchBtn.onStyle() : catchBtn.offStyle()
        self.pokemon.isCaught ? cell.onStyle() : cell.offStyle()
    }

    @IBAction func catchBtnTapped(_ sender: UIButton) {
        pokemon?.isCaught.toggle()
        if let poke = pokemon {
            delegate?.didChangeStatusValue(id: poke.id, newValue: poke.isCaught)
            status.text = poke.isCaught ? "Caught" : "-"
            poke.isCaught ? catchBtn.onStyle() : catchBtn.offStyle()
            poke.isCaught ? cell.onStyle() : cell.offStyle()
        }
    }
}
