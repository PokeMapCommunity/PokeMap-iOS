//
//  PokemonMapItemViewModel.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift
import DateTools
import MapKit

class PokemonMapItemViewModel {

  private let pokemon: Pokemon

  let identifier: String
  let title: String
  let imageURL: NSURL
  let latitude: Double
  let longitude: Double

  var timeLeft: Observable<String> {
    return Observable
      .combineLatest(Observable.just(pokemon.expirationTime), NSTimer.rx_timer) { ($0, $1) }
      .map { (created, _) in
        "Expires in \(created.shortTimeAgoSinceNow())"
    }
  }

  var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }

  var annotation: PokemonAnnotation {
    let annotation = PokemonAnnotation(coordinate: coordinate, identifier: pokemon.uid,
                                       title: title, expiration: pokemon.expirationTime,
                                       imageURL: imageURL)
    timeLeft.subscribeNext { timeLeft in
      annotation.subtitle = timeLeft
    }.addDisposableTo(annotation.rx_disposeBag)
    return annotation
  }

  func distance(latitude: Double, longitude: Double) -> String {
    return ""
  }

  init(pokemon: Pokemon) {
    self.pokemon = pokemon

    self.identifier = (pokemon.identifier as NSNumber).stringValue
    self.title = "#\(pokemon.pokemonId) - \(pokemon.name)"
    self.imageURL = pokemon.imageURL
    self.latitude = pokemon.latitude
    self.longitude = pokemon.longitude
  }
}
