//
//  PokeService.swift
//  PokemonApp
//
//  Created by TempStudent on 2023. 08. 07..
//

import Foundation

enum PokeServiceError: Error {
    case unknownError(String = "An unknown error occurred.")
    case serverError(String = "A server error occurred.")
    case localError(String = "A local error occurred.")
    case decodingError(String = "A decoding error occurred.")
}

class PokeService {
    static func fetchData<T: Decodable>(with endpoint: Endpoint, completion: @escaping (Result<T, PokeServiceError>)->Void) {
        guard let request = endpoint.request else { return }
        URLSession.shared.dataTask(with: request) { data, resp, error in
            // Checking for Local Error
            if let error = error {
                completion(.failure(.localError(error.localizedDescription)))
                return
            }
            // Checking for Server Error
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                completion(.failure(.serverError()))
                return
            }
            // Parse the Data
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let pokeData = try decoder.decode(T.self, from: data)
                    completion(.success(pokeData))
                } catch let err{
                    completion(.failure(.decodingError()))
                    print(err.localizedDescription)
                }
            } else {
                completion(.failure(.unknownError()))
            }
        }.resume()
    }
}
