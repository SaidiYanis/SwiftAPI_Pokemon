//
//  PokemonAPI.swift
//  PokemonSwiftUI
//
//  Created by Brais Moure on 28/10/22.
//

// PokemonAPI.swift

import Foundation

final class PokemonApi {
    func loadPokemon(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        guard let url = URL(string: "https://pokebuildapi.fr/api/v1/pokemon") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
                return
            }

            do {
                let pokemons = try JSONDecoder().decode([Pokemon].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(pokemons))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
