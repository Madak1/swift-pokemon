//
//  DetailVC.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 04..
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var weight: UILabel!
    @IBOutlet var height: UILabel!
    @IBOutlet var ability1: UILabel!
    @IBOutlet var ability2: UILabel!
    @IBOutlet var ability3: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var catchBtn: UIButton!
    
    weak var delegate: StatusChangerDelegate?
    
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupImage()
        self.setupLabels()
    }
    
    private func setupImage() {
        // TODO
    }
    
    private func setupLabels() {
        if let poke = pokemon {
            name.text = poke.name
            weight.text = String(poke.weight/10) + "kg"
            height.text = String(poke.height/10) + "m"
            for ability in poke.abilities {
                if !ability.isHiden {
                    findNextAbility().text = ability.name
                }
            }
            status.text = poke.isCaught ? "Caught" : "-"
            catchBtn.setTitle(poke.isCaught ? "Release" : "Catch", for: .normal)
        }
    }
    
    private func findNextAbility() -> UILabel {
        if ability1.text == "Label" {
            return ability1
        } else if ability2.text == "Label" {
            return ability2
        } else {
            return ability3
        }
    }
    
    @IBAction func catchBtnTapped(_ sender: UIButton) {
        pokemon?.isCaught.toggle()
        if let poke = pokemon {
            delegate?.didChangeStatusValue(id: poke.id, newValue: poke.isCaught)
            status.text = poke.isCaught ? "Caught" : "-"
            catchBtn.setTitle(poke.isCaught ? "Release" : "Catch", for: .normal)
        }
    }
    
}

