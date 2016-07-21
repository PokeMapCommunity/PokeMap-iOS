//
//  PokemonMapViewModel.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift
import Moya_ObjectMapper

class PokemonMapViewModel {

  private let pokemons: Variable<[Pokemon]> = Variable([])

  var viewModels: Observable<[PokemonMapItemViewModel]> {
    return Observable.combineLatest(pokemons.asObservable(), NSTimer.rx_timer) { ($0, $1) }
      .map { (pokemons, _) in
        pokemons.filter { !$0.expired && $0.isAlive }
          .map { PokemonMapItemViewModel(pokemon: $0) }
    }
  }

  func loadPokemons(latitude: Double, longitude: Double, jobId: String?) -> Observable<Void> {
    return Network.request(API.Pokemons(latitude: latitude, longitude: longitude, jobId: jobId))
      .mapArray(Pokemon.self, key: "pokemon")
      .doOnNext { [weak self] pokemons in
        guard let `self` = self else { return }
        let allPokemons = (pokemons + self.pokemons.value).unique
        self.pokemons.value = allPokemons
    }.map(void)
  }

}
