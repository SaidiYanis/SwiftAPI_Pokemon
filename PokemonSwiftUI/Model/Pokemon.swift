//
//  Pokemon.swift
//  PokemonSwiftUI
//
//  Created by Brais Moure on 28/10/22.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let pokedexId: Int
    let name: String
    let image: String
    let sprite: String
    let slug: String
    let apiTypes: [PokemonType]
    let apiResistances: [PokemonResistance]
}

struct PokemonType: Decodable {
    let name: String
    let image: String
}

struct PokemonResistance: Decodable {
    let name: String
    let damageRelation: String?
}

struct PokemonList: Decodable {
    let results: [Pokemon]
}



    
//    var id: Int? {
//        return Int(url.split(separator: "/").last?.description ?? "0")
//    }
//    
//    var imageUrl: URL? {
//        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id ?? 0).png")
//    }


