//
//  HomeVC.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 04..
//

import UIKit

protocol StatusChangerDelegate: AnyObject {
    func didChangeStatusValue(id: UUID, newValue: Bool)
}

class HomeVC: UIViewController, StatusChangerDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var pokemons: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemons = fetchTestData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DetailVC
        destVC.delegate = self
        destVC.pokemon = sender as? Pokemon
    }

    func didChangeStatusValue(id: UUID, newValue: Bool) {
        guard let idx = pokemons.firstIndex(where: {$0.id==id}) else {
            return
        }
        pokemons[idx].isCaught = newValue
        tableView.reloadData()
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell") as! PokemonCell
        cell.delegate = self
        cell.setPokemon(pokemon: pokemons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetailsVC", sender: pokemons[indexPath.row])
    }
    
}


extension HomeVC {
    func fetchTestData() -> [Pokemon] {
        let p00 = Pokemon(
            name: "Charmander",
            type: "Fire",
            weight: 85,
            height: 6,
            abilities: [
                PokeAbility(name: "blaze", isHiden: false),
                PokeAbility(name: "solar-power", isHiden: true)
            ]
        )
        let p01 = Pokemon(
            name: "Pikachu",
            type: "Electric",
            weight: 65,
            height: 4,
            abilities: [
                PokeAbility(name: "static", isHiden: false),
                PokeAbility(name: "lightning-rod", isHiden: true)
            ]
        )
        let p02 = Pokemon(
            name: "Dugtrio",
            type: "Ground",
            weight: 333,
            height: 7,
            abilities: [
                PokeAbility(name: "sand-veil", isHiden: false),
                PokeAbility(name: "arena-trap", isHiden: false),
                PokeAbility(name: "sand-force", isHiden: true)
            ]
        )
        let p03 = Pokemon(
            name: "Mewtwo",
            type: "Psychic",
            weight: 1220,
            height: 20,
            abilities: [
                PokeAbility(name: "pressure", isHiden: false),
                PokeAbility(name: "unnerve", isHiden: true)
            ]
        )
        let p04 = Pokemon(
            name: "Arbok",
            type: "Poison",
            weight: 650,
            height: 35,
            abilities: [
                PokeAbility(name: "intimidate", isHiden: false),
                PokeAbility(name: "shed-skin", isHiden: false),
                PokeAbility(name: "unnerve", isHiden: true)
            ]
        )
        let p05 = Pokemon(
            name: "Chimecho",
            type: "Psychic",
            weight: 10,
            height: 6,
            abilities: [
                PokeAbility(name: "levitate", isHiden: false)
              
            ]
        )
        return [p00, p01, p02, p03, p04, p05]
    }
}

