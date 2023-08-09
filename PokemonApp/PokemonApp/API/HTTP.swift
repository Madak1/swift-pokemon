//
//  HTTP.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 07..
//

import Foundation

enum HTTP {
    
    // PokeAPI is a consumption-only API — only the HTTP GET method is available.
    enum Method: String {
        case get = "GET"
        // case post = "POST"
        // case put = "PUT"
        // case delete = "DELETE"
        // ...
    }
    
    // Content-Type and application/json are not needed for GET request.
    //  - It just tells the server what kind of data we are sending.
    enum Headers {
        enum Key: String {
            case contentType = "Content-Type"
            // Enter the key of the API_KEY here if required (Not required for PokeAPI)
        }
        enum Value: String {
            case applicationJson = "application/json"
        }
    }
    
}

