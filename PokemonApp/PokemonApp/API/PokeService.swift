//
//  PokeService.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 07..
//

import Foundation


enum PokeServiceError: Error {
    
    // Error cases
    case invalidRequest
    case serverError(Int)
    case networkError(Error)
    case decodingError(Error)
    case unexpectedResponseFormat
    case noDataReceived
    
    // Error descriptions
    var description: String {
        switch self {
        case .invalidRequest:
            return "Invalid request."
        case .networkError(let error):
            return "Network Error - Description: \(error.localizedDescription)"
        case .unexpectedResponseFormat:
            return "Unexpected response format."
        case .serverError(let statusCode):
            return "Server Error - Status code: \(statusCode)"
        case .decodingError(let error):
            return "Decoding Error - Description: \(error.localizedDescription)"
        case .noDataReceived:
            return "No data received."
        }
    }
    
}


class PokeService {
    
    // Fetching JSON data from API
    static func fetchData<T: Decodable>(with endpoint: Endpoint, completion: @escaping (Result<T, PokeServiceError>)->Void) {
        
        // Check request
        guard let request = endpoint.request else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Check network connectivity issues
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            // Check response format
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unexpectedResponseFormat))
                return
            }
            // Check server response
            if !httpResponse.isSuccessful {
                completion(.failure(.serverError(httpResponse.statusCode)))
                return
            }
            // Check data
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            // Decoding
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let error {
                completion(.failure(.decodingError(error)))
            }
            
        }
        task.resume()
    }
    
}

