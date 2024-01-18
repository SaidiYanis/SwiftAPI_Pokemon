//
//  GameView.swift
//  PokemonSwiftUI
//
//  Created by SDV Bordeaux on 18/01/2024.
//
import SwiftUI

struct GameView: View {
    @State private var pokemonList: [Pokemon] = []
    @State private var leftPokemon: Pokemon? = nil
    @State private var rightPokemon: Pokemon? = nil
    @State private var score = 0

    var body: some View {
        VStack {
            if let leftPokemon = leftPokemon, let rightPokemon = rightPokemon {
                VStack {
                    Text("Score: \(score)")
                    Text("Left: \(leftPokemon.name) - Right: \(rightPokemon.name)")
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            handleSwipe(value: value)
                        }
                )
            } else {
                Text("Chargement des Pokémon...")
                    .onAppear {
                        loadPokemons()
                    }
            }
        }
    }

    // Chargement des Pokémon depuis l'API
    func loadPokemons() {
        PokemonApi().loadPokemon { result in
            switch result {
            case .success(let loadedPokemonList):
                self.pokemonList = loadedPokemonList
                setupGame()
            case .failure(let error):
                print("Erreur lors du chargement des Pokémon: \(error)")
            }
        }
    }

    // Configuration initiale du jeu
    func setupGame() {
        guard pokemonList.count >= 2 else { return }
        leftPokemon = pokemonList.randomElement()
        rightPokemon = pokemonList.randomElement()
    }

    // Gestion des swipes
    func handleSwipe(value: DragGesture.Value) {
        let winner = determineWinner(leftResult: evaluateTypes(attackingPokemon: leftPokemon!, defendingPokemon: rightPokemon!),
                                     rightResult: evaluateTypes(attackingPokemon: rightPokemon!, defendingPokemon: leftPokemon!))

        switch winner {
        case "1": // Gauche gagne
            score += 1
            rightPokemon = pokemonList.randomElement()
        case "2": // Droite gagne
            score += 1
            leftPokemon = rightPokemon
            rightPokemon = pokemonList.randomElement()
        case "3": // Match nul
            score += 1
            setupGame()
        default:
            gameOver()
        }
    }

    // Logique de détermination de l'efficacité
    private func isEffective(_ leftPokemon: Pokemon, against rightPokemon: Pokemon) -> Bool {
        let leftResult = evaluateTypes(attackingPokemon: leftPokemon, defendingPokemon: rightPokemon)
        let rightResult = evaluateTypes(attackingPokemon: rightPokemon, defendingPokemon: leftPokemon)

        return determineWinner(leftResult: leftResult, rightResult: rightResult) == "1"
    }

    // Logique pour déterminer si le match est neutre
    private func isNeutral(_ leftPokemon: Pokemon, against rightPokemon: Pokemon) -> Bool {
        let leftResult = evaluateTypes(attackingPokemon: leftPokemon, defendingPokemon: rightPokemon)
        let rightResult = evaluateTypes(attackingPokemon: rightPokemon, defendingPokemon: leftPokemon)

        return leftResult == "neutral" && rightResult == "neutral"
    }

    // Évaluation des types
    private func evaluateTypes(attackingPokemon: Pokemon, defendingPokemon: Pokemon) -> String {
        let results = attackingPokemon.apiTypes.map { attackingType in
            defendingPokemon.apiResistances.first { $0.name == attackingType.name }?.damageRelation ?? "neutral"
        }
        return finalizeResult(results)
    }

    private func finalizeResult(_ results: [String]) -> String {
        let combinedResult = results.reduce("neutral") { (current, result) in
            switch (current, result) {
            case ("neutral","neutral"), ("neutral", "neutral"), ("neutral", _):
                return "neutral"
            case ("resistant", "vulnerable"), ("vulnerable", "resistant"):
                return "neutral"
            case ("resistant", "resistant"), ("resistant", _):
                return "resistant"
            case ("neutral", "vulnerable"), ("vulnerable", "neutral"):
                return "vulnerable"
            case ("neutral", "resistant"), ("resistant", "neutral"):
                return "resistant"
            case ("vulnerable", "vulnerable"), ("vulnerable", _):
                return "vulnerable"
            default:
                return current
            }
        }
        return combinedResult
    }

    private func determineWinner(leftResult: String, rightResult: String) -> String {
        if leftResult == rightResult {
            return "3" // Match nul
        }

        switch (leftResult, rightResult) {
        case ("resistant", "vulnerable"), ("neutral", "vulnerable"):
            return "1" // Le Pokémon de gauche gagne
        case ("vulnerable", "resistant"), ("vulnerable", "neutral"):
            return "2" // Le Pokémon de droite gagne
        default:
            return "3" // Match nul pour les autres combinaisons
        }
    }

        private func gameOver() {
            score = 0
            setupGame()
        }
    }
