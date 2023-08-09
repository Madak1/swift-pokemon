//
//  DetailVC.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 04..
//

import UIKit

class DetailVC: UIViewController {
    
    // MARK: UI components
    
    @IBOutlet var imageView: PokeImage!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var ability1Label: UILabel!
    @IBOutlet var ability2Label: UILabel!
    @IBOutlet var ability3Label: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var catchBtn: PokeButton!
    @IBOutlet var imageSpinner: PokeSpinner!
    
    // MARK: Variables
    
    weak var delegate: CatchBtnDelegate?
    var pokemon: Pokemon?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupImage()
        self.setupLabels()
    }
    
    // MARK: Setup Pokemon Image
    
    private func setupImage() {
        if let imgUrlString = pokemon?.imageURL {
            guard let imgUrl = URL(string: imgUrlString) else { return }
            let dataTask = URLSession.shared.dataTask(with: imgUrl) { (data, _, error) in
                if let _ = error { return }
                guard let imageData = data else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                    self.imageSpinner.offStyle()
                }
            }
            dataTask.resume()
        } else {
            self.imageView.image = UIImage(named: "PokeBall")
            self.imageSpinner.offStyle()
        }
    }
    
    // MARK: Setup Pokemon detail Labels
    
    private func setupLabels() {
        if let poke = self.pokemon {
            self.nameLabel.text = poke.name.capitalized
            self.weightLabel.text = String(Double(poke.weight)/10) + "kg"
            self.heightLabel.text = String(Double(poke.height)/10) + "m"
            for (i, ability) in poke.abilities.enumerated() {
                switch i {
                case 0:
                    self.ability1Label.text = ability.capitalized
                case 1:
                    self.ability2Label.text = ability.capitalized
                default:
                    self.ability3Label.text = ability.capitalized
                }
            }
            self.statusLabel.text = poke.isCaught ? "Caught" : "-"
            poke.isCaught ? imageView.onStyle() : imageView.offStyle()
            poke.isCaught ? catchBtn.onStyle() : catchBtn.offStyle()
        }
    }
    
    // MARK: Catch Button
    
    @IBAction func catchBtnTapped(_ sender: UIButton) {
        pokemon?.isCaught.toggle()
        if let poke = pokemon {
            delegate?.didChangeStatusValue(id: poke.id, newValue: poke.isCaught)
            statusLabel.text = poke.isCaught ? "Caught" : "-"
            poke.isCaught ? imageView.onStyle() : imageView.offStyle()
            poke.isCaught ? catchBtn.onStyle() : catchBtn.offStyle()
        }
    }
    
}

