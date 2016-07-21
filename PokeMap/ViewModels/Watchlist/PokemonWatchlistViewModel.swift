//
//  PokemonWatchlistViewModel.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift

class PokemonWatchlistViewModel {

  private let _viewModels: Variable<[PokemonWatchlistItemViewModel]>

  var viewModels: Observable<[PokemonWatchlistItemViewModel]> {
    return _viewModels.asObservable()
  }

  init() {
    let allPokemons = PokedexHelper.sharedInstance.allPokemons(151)
      .map { PokemonWatchlistItemViewModel(identifier: $0.0, name: $0.1) }

    _viewModels = Variable(allPokemons.sort { (lhs, rhs) -> Bool in
      return Int(lhs.identifier) < Int(rhs.identifier)
      })
  }

  func watch(index: Int) {
    let viewModel = _viewModels.value[index]
    var watchlist = Globals.watchlist
    watchlist.append(viewModel.identifier)
    Globals.watchlist = watchlist
    viewModel.watched.value = true
  }

  func unwatch(index: Int) {
    let viewModel = _viewModels.value[index]
    if let index = Globals.watchlist.indexOf(viewModel.identifier) {
      Globals.watchlist.removeAtIndex(index)
    }
    viewModel.watched.value = false
  }
}
