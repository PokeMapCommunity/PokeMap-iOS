//
//  PokemonWatchlistItemViewModel.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift

class PokemonWatchlistItemViewModel {

  let identifier: String
  let text: String
  var watched: Variable<Bool>


  var imageURL: NSURL {
    return NSURL(string: "https://ugc.pokevision.com/images/pokemon/\(identifier).png")!
  }

  init(identifier: String, name: String) {
    self.identifier = identifier
    self.text = "\(identifier) - \(name)"
    self.watched = Variable(Globals.watchlist.contains(identifier))
  }

}
