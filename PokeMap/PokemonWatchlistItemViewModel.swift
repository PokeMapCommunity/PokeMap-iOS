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
  
  let id: String
  let text: String
  var watched: Variable<Bool>
  
  
  var imageURL: NSURL {
    return NSURL(string: "https://ugc.pokevision.com/images/pokemon/\(id).png")!
  }
  
  init(id: String, name: String) {
    self.id = id
    self.text = "\(id) - \(name)"
    self.watched = Variable(Globals.watchlist.contains(id))
  }
  
}