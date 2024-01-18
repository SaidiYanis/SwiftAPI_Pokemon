//
//  PokemonCellView.swift
//  PokemonSwiftUI
//
//  Created by Brais Moure on 28/10/22.
//

// PokemonCellView.swift
import SwiftUI

struct PokemonCellView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.image)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60)
                        .clipShape(Circle())
                case .failure(_):
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .padding()
                        .frame(width: 60, height: 60)
                case .empty:
                    Image(systemName: "photo.circle")
                        .resizable()
                        .padding()
                        .frame(width: 60, height: 60)
                @unknown default:
                    EmptyView()
                }
            }
            .background(Color.gray.opacity(0.1))
            
            Text("#\(pokemon.pokedexId)")
                .font(.title2)
                .fontWeight(.light)
            
            Text(pokemon.name.capitalized)
                .font(.title)
                .fontWeight(.medium)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 3)
    }
}
