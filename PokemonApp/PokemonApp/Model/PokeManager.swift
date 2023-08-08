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
    var onErrorMessage: ((PokeServiceError)->Void)?
    
    // MARK: Data
    
    private(set) var pokemons: [Pokemon] = [] {
        didSet {
            self.onPokemonsUpdated?()
        }
    }
    
    private var allPokemon: [Pokemon] = [] {
        didSet {
            // If all Pokemon fetched
            if allPokemon.count == pokeUrlList.count {
                // If filtering is Off
                if !isFilterOn {
                    allPokemon.sort(by: {$0.id < $1.id})
                    self.pokemons = self.allPokemon
                }
            }
        }
    }
    
    private var pokeUrlList: [PokemonURL] = [] {
        didSet {
            for pokeURL in pokeUrlList {
                self.fetchPokemon(by: pokeURL.name)
            }
        }
    }
    
    private(set) var pokeTypes: [String] = [] {
        didSet {
            pokeTypes.append("")
            pokeTypes.sort()
            self.onTypesUpdated?()
        }
    }
    
    // MARK: Update Data
    
    func updateCatchStatus(where id: Int, to value: Bool) {
        guard let idx = self.allPokemon.firstIndex(where: {$0.id==id}) else { return }
        guard let filteredIdx = self.pokemons.firstIndex(where: {$0.id==id}) else { return }
        self.allPokemon[idx].isCaught = value
        self.pokemons[filteredIdx].isCaught = value
    }
    
    // MARK: Filter Data
    
    private var isFilterOn = false
    
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
        // Filtering by type TODO: optional
        tmpPokemons = type.isEmpty ? tmpPokemons : tmpPokemons.filter({$0.types.contains(type)})
        // Filtering by status
        self.pokemons = !status ? tmpPokemons : tmpPokemons.filter({$0.isCaught == true})
    }
    
    // MARK: Fetch Data
    
    public func fetchPokemon(by name: String) {
        let endpoint = Endpoint.fetchPokemonByName(name: name)
        PokeService.fetchData(with: endpoint) { (result: Result<Pokemon, PokeServiceError>) in
            switch result {
            case .success(let pokemon):
                self.allPokemon.append(pokemon)
            case .failure(let error):
                self.onErrorMessage?(error)
            }
        }
    }
    
    public func fetchPokemons() {
        let endpoint = Endpoint.fetchPokemons()
        PokeService.fetchData(with: endpoint) { (result: Result<PokemonList, PokeServiceError>) in
            switch result {
            case .success(let pokeUrlList):
                self.pokeUrlList = pokeUrlList.pokemons
            case .failure(let error):
                self.onErrorMessage?(error)
            }
        }
    }
    
    public func fetchPokemonTypes() {
        let endpoint = Endpoint.fetchPokemonTypes()
        PokeService.fetchData(with: endpoint) { (result: Result<PokemonTypes, PokeServiceError>) in
            switch result {
            case .success(let result):
                self.pokeTypes = result.types.map({$0.name})
            case .failure(let error):
                self.onErrorMessage?(error)
            }
        }
    }
    
}

