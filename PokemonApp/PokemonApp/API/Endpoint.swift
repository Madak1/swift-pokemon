//
//  Endpoint.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 07..
//

import Foundation

enum Endpoint {
    
    // Endpoints
    case fetchPokemons(url: String = "/api/v2/pokemon", limit: Int = 1500)
    case fetchPokemonByID(url: String = "/api/v2/pokemon", id: Int)
    case fetchPokemonByName(url: String = "/api/v2/pokemon", name: String)
    case fetchPokemonTypes(url: String = "/api/v2/type")
    
    // Create request
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValues(for: self)
        return request
    }
    
    // Create the URL
    private var url: URL? {
        var components = URLComponents()
        components.scheme = PokeApi.scheme
        components.host = PokeApi.baseURL
        components.port = PokeApi.port
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    
    // Return the path to the endpoint
    private var path: String {
        switch self {
        case .fetchPokemons(url: let url, limit: _):
            return url
        case .fetchPokemonByID(url: let url, id: let id):
            return url + "/\(id)"
        case .fetchPokemonByName(url: let url, name: let name):
            return url + "/" + name
        case .fetchPokemonTypes(url: let url):
            return url
        }
    }
    
    // Return with query params
    private var queryItems: [URLQueryItem] {
        switch self {
        case .fetchPokemons(url: _, limit: let limit):
            return [
                // The default limit is 20, but we want all Pokemon
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
        default:
            return []
        }
    }
    
    // Only GET method
    private var httpMethod: String {
        switch self {
        default:
            return HTTP.Method.get.rawValue
        }
    }
    
    // Body doesn't need for GET request.
    private var httpBody: Data? {
        switch self {
        default:
            return nil
        }
    }
}

extension URLRequest {
    // Add key-value pairs to the header
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        default:
            // Content-Type and application/json are not needed for GET request. (So this part is not necessary)
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
        }
    }
}

