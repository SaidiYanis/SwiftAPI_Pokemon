//
//  PokemonListView.swift
//  PokemonSwiftUI
//
//  Created by Brais Moure on 28/10/22.
//
// PokemonListView.swift
// PokemonListView.swift
import SwiftUI

struct PokemonListView: View {
    @State private var pokemonList: [Pokemon] = []

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                    ForEach(pokemonList, id: \.id) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonCellView(pokemon: pokemon)
                                .frame(height: 150)
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                loadPokemons()
            }
            .navigationTitle("Liste des Pokémon")
        }
    }

    func loadPokemons() {
        PokemonApi().loadPokemon { result in
            switch result {
            case .success(let loadedPokemonList):
                self.pokemonList = loadedPokemonList
                print("Pokémon chargés : \(self.pokemonList.count)") // Ajoutez ceci pour vérifier
            case .failure(let error):
                print("Erreur lors du chargement des Pokémon: \(error)")
            }
        }
    }

    struct PokemonListView_Previews: PreviewProvider {
        static var previews: some View {
            PokemonListView() // Modification ici
        }
    }
}
