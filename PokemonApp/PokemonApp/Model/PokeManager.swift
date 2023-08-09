//
//  PokeManager.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 07..
//

import Foundation

class PokeManager {
    
    var onPokemonsUpdated: (()->Void)?
    var onTypesUpdated: (()->Void)?
    
    // Is there any filter on?
    private var isFilterOn = false
    
    // MARK: Data
    
    // Filtered Pokemons (TableView content)
    private(set) var pokemons: [Pokemon] = [] {
        didSet {
            // Pokemon array is updated
            self.onPokemonsUpdated?()
        }
    }
    
    // All Pokemon
    private var allPokemon: [Pokemon] = [] {
        didSet {
            // If all Pokemon fetched
            if allPokemon.count == pokeUrlList.count {
                // If filtering is Off and the two array is not equal
                if !isFilterOn && self.pokemons.count != self.allPokemon.count {
                    // Sorted pokemons by ID
                    allPokemon.sort(by: {$0.id < $1.id})
                    // Filtered Pokemons get all Pokemons
                    self.pokemons = self.allPokemon
                }
            }
        }
    }
    
    // All Pokemon name and URL
    private var pokeUrlList: [PokemonURL] = [] {
        didSet {
            // Fetch all Pokemons
            for poke in pokeUrlList {
                self.fetchPokemon(by: poke.name)
            }
        }
    }
    
    // All Pokemon type (PickerView content)
    private(set) var pokeTypes: [String] = [] {
        didSet {
            // Add an empty element -> No type filter
            pokeTypes.append("")
            // Sort the array by name
            pokeTypes.sort()
            // Type array is updated
            self.onTypesUpdated?()
        }
    }
    
    // MARK: Update Data
    
    // Update the catch status of the selected Pokemon in both array
    public func updateCatchStatus(where id: Int, to value: Bool) {
        guard let idx = self.allPokemon.firstIndex(where: {$0.id==id}) else { return }
        guard let filteredIdx = self.pokemons.firstIndex(where: {$0.id==id}) else { return }
        self.allPokemon[idx].isCaught = value
        self.pokemons[filteredIdx].isCaught = value
    }
    
    // MARK: Filter Data
    
    // Filter the Pokemons by the given filters
    public func filteringPokemonsBy(name: String, type: String, status: Bool) {
        // Is there any filter?
        self.isFilterOn = !name.isEmpty || !type.isEmpty || status
        if !self.isFilterOn {
            self.pokemons = self.allPokemon
            return
        }
        // Filtering by name
        var tmpPokemons = name.isEmpty ? allPokemon : allPokemon.filter(
            {$0.name.lowercased().contains(name.lowercased())}
        )
        // Filtering by type
        tmpPokemons = type.isEmpty ? tmpPokemons : tmpPokemons.filter({$0.types.contains(type.lowercased())})
        // Filtering by status
        self.pokemons = !status ? tmpPokemons : tmpPokemons.filter({$0.isCaught == true})
    }

    // MARK: Get Data
    
    // Get all Pokemon type
    public func fetchPokemonTypes() {
        let endpoint = Endpoint.fetchPokemonTypes()
        PokeService.fetchData(with: endpoint) { (result: Result<PokemonTypes, PokeServiceError>) in
            switch result {
            case .success(let result):
                self.pokeTypes = result.types.map({$0.name})
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    // Get all Pokemon name and URL
    public func fetchPokemons() {
        let endpoint = Endpoint.fetchPokemons()
        PokeService.fetchData(with: endpoint) { (result: Result<PokemonList, PokeServiceError>) in
            switch result {
            case .success(let pokeUrlList):
                self.pokeUrlList = pokeUrlList.pokemons
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    // Get a Pokemon by ID
    public func fetchPokemon(by id: Int) {
        let endpoint = Endpoint.fetchPokemonByID(id: id)
        PokeService.fetchData(with: endpoint) { (result: Result<Pokemon, PokeServiceError>) in
            switch result {
            case .success(let pokemon):
                self.allPokemon.append(pokemon)
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    // Get a Pokemon by Name
    public func fetchPokemon(by name: String) {
        let endpoint = Endpoint.fetchPokemonByName(name: name)
        PokeService.fetchData(with: endpoint) { (result: Result<Pokemon, PokeServiceError>) in
            switch result {
            case .success(let pokemon):
                self.allPokemon.append(pokemon)
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
}

