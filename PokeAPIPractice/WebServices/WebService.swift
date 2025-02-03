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
    
    func getPokemonList(limit: Int, offset: Int,completion: @escaping (Result<PokemonList, NetworkError>) -> Void) {
        guard let pokeApiUrl = URL.urlGetPokemonList(limit: limit, offset: offset) else {
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
    
    func getPokemonByUrl(url: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        guard let pokeApiUrl = (URL(string: url)) else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: pokeApiUrl) { (data, _, error) in
            
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let pokeResponse = try? JSONDecoder().decode(Pokemon.self, from: data)
            
            
            DispatchQueue.main.async {
                if let pokeResponse = pokeResponse {
                    completion(.success(pokeResponse))
                }
            }//DispatchQ

        }.resume()  //: URLSession
        
    }
    
    func getTokyoHour(completion: @escaping (Result<TimeAPIResponse, NetworkError>) -> Void) {
        guard let timeApiUrl = URL.urlGetTokyoTime() else {
            return(completion(.failure(.badURL)))
        }
        
        URLSession.shared.dataTask(with: timeApiUrl) { (data, _, error) in
        
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let timeResponse = try? JSONDecoder().decode(TimeAPIResponse.self, from: data)
            
            DispatchQueue.main.async {
                if let timeResponse = timeResponse {
                    completion(.success(timeResponse))
                }
                
            }//:DQ
            
            
        }.resume()
        
    }
    
    
}
