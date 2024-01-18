//
//  HomeView.swift
//  PokemonSwiftUI
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Voir la liste des Pokémon", destination: PokemonListView())
                NavigationLink("Jouer au jeu", destination: GameView())
            }
            .navigationTitle("Accueil")
        }
    }
    struct HomePageView_Previews: PreviewProvider {
        static var previews: some View {
            HomePageView()
        }
    }
}
