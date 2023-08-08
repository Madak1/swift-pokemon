//
//  HTTP.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 07..
//

import Foundation

enum HTTP {
    
    enum Method: String {
        case get = "GET"
        // PokeAPI is a consumption-only API — only the HTTP GET method is available.
        // case post = "POST"
        // case post = "PUT"
        // case post = "DELETE"
        // ...
    }
    
    // Content-Type and application/json doesn't need for GET request.
    //  - It just tells the server what kind of data we are sending.
    enum Headers {
        enum Key: String {
            case contentType = "Content-Type"
            // Enter the key of the API key if required (Not required for PokeAPI)
        }
        enum Value: String {
            case applicationJson = "application/json"
        }
    }
}

