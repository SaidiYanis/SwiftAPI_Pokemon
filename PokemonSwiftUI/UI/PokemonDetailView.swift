//
//  PokemonDetailView.swift
//  PokemonSwiftUI
//
//  Created by SDV Bordeaux on 18/01/2024.
//
// PokemonDetailView.swift
// PokemonDetailView.swift
import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.image)) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "photo")
            }
            Text(pokemon.name)
            Text("#\(pokemon.pokedexId)")
            HStack {
                ForEach(pokemon.apiTypes, id: \.name) { type in
                    Text(type.name)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
        .navigationTitle(pokemon.name)
    }
}
