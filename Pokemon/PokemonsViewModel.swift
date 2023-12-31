//
//  PokemonsViewModel.swift
//  Pokemon
//
//  Created by user244602 on 8/2/23.
//

import Foundation

struct Pokemon : Codable {
    var results: [PokemonEntry]
}

struct PokemonEntry : Codable, Identifiable  {
    let id = UUID()
    var name: String
    var url: String
}

class PokemonApi {
    
    func getData(completion:@escaping ([PokemonEntry]) -> ()) {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=15") else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                
                let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data)
                
                DispatchQueue.main.async {
                    completion(pokemonList.results)
                }
            }.resume()
        }
}
