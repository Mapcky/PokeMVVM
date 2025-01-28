//
//  WebService.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
}

class WebService {
    
    func getPokemonByName(name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        guard let pokeApiURL = URL.urlGetPokemon(pokemon: name) else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: pokeApiURL) {
            (data, _, error) in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let pokeResponse = try? JSONDecoder().decode(Pokemon.self, from: data)
            
            DispatchQueue.main.async {
                if let pokeResponse = pokeResponse {
                    completion(.success(pokeResponse))
                }
            }
            
        }.resume()
    }
    
    func getPokemonList(completion: @escaping (Result<PokemonList, NetworkError>) -> Void) {
        guard let pokeApiUrl = URL.urlGetPokemonList() else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: pokeApiUrl) { (data, _, error) in
            
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let pokeResponse = try? JSONDecoder().decode(PokemonList.self, from: data)
            
            
            DispatchQueue.main.async {
                if let pokeResponse = pokeResponse {
                    completion(.success(pokeResponse))
                }
            }//DispatchQ

        }.resume()  //: URLSession
        
    }
    
}
