//
//  PokedexHelper.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

class PokedexHelper {

  private let pokemonHash: [String: String]

  static let sharedInstance = PokedexHelper()

  init() {
    pokemonHash = JSONReader.readJSONDictionary("Pokedex")
  }

  func allPokemons(maxNumber: Int) -> [String: String] {
    var pokemons = [String: String]()
    for number in 1...maxNumber {
      let id = "\(number)"
      pokemons[id] = nameFromId(id)
    }
    return pokemons
  }

  func nameFromId(pokemonId: String) -> String {
    return pokemonHash[pokemonId] ?? "Missigno"
  }

}
