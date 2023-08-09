//
//  Pokemon.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 04..
//

import Foundation

// MARK: All Pokemon Type

struct PokemonTypes: Decodable {
    let count: Int
    let types: [PokemonType]
    
    enum CodingKeys: String, CodingKey {
        case count
        case types = "results"
    }
}

struct PokemonType: Decodable {
    let name: String
    let url: String
}

// MARK: All Pokemon's name and URL

struct PokemonList: Decodable {
    let count: Int
    let pokemons: [PokemonURL]
    
    enum CodingKeys: String, CodingKey {
        case count
        case pokemons = "results"
    }
}

struct PokemonURL: Decodable {
    let name: String
    let url: String
}

// MARK: One Pokemon

struct Pokemon: Decodable {
    
    let id: Int
    let name: String
    let types: [String]
    let weight: Int
    let height: Int
    let abilities: [String]
    let imageURL: String?
    var isCaught: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, name, types, weight, height, abilities, sprites, other
        case officialArtwork = "official-artwork"
        case imageURL = "front_default"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.types = try container.decode([PokeType].self, forKey: .types).map({$0.name})
        self.weight = try container.decode(Int.self, forKey: .weight)
        self.height = try container.decode(Int.self, forKey: .height)
        self.abilities = try container.decode([PokeAbility].self, forKey: .abilities).filter { !$0.isHidden }.map { $0.ability }
        
        let sprites = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .sprites)
        let other = try sprites.nestedContainer(keyedBy: CodingKeys.self, forKey: .other)
        let officialArtwork = try other.nestedContainer(keyedBy: CodingKeys.self, forKey: .officialArtwork)
        self.imageURL = try officialArtwork.decodeIfPresent(
            String.self,
            forKey: .imageURL
        ) ?? sprites.decodeIfPresent(String.self, forKey: .imageURL) ?? nil
    }
}

private struct PokeType: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .type)
        name = try type.decode(String.self, forKey: .name)
    }
}

private struct PokeAbility: Decodable {
    let ability: String
    let isHidden: Bool
    
    enum CodingKeys: String, CodingKey {
        case abilityInfo = "ability"
        case ability = "name"
        case isHidden = "is_hidden"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let abilityInfo = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .abilityInfo)
        ability = try abilityInfo.decode(String.self, forKey: .ability)
        isHidden = try container.decode(Bool.self, forKey: .isHidden)
    }
}

