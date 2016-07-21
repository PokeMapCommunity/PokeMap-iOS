//
//  LocationHelper.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import CoreLocation
import RxCocoa
import RxOptional
import RxSwift

class LocationHelper {
  
  static let sharedInstance = LocationHelper()
  
  private let locationManager: CLLocationManager
  private var disposeBag = DisposeBag()
  private var notifiedPokemons = [Pokemon]()

  init() {
    locationManager = CLLocationManager()
    locationManager.distanceFilter = 1
  }
  
  func start() {
    locationManager.startMonitoringSignificantLocationChanges()
    locationManager.rx_didUpdateLocations
      .map { $0.first }
      .debug()
      .filterNil()
      .flatMap { location in
        LocationHelper.loadPokemons(location.coordinate.latitude,
          longitude: location.coordinate.longitude).retry(2)
      }
      .filter { $0.count > 0 }
      .subscribeNext { pokemons in
        let watchlistedPokemons = pokemons
          .filter { Globals.watchlist.contains($0.id) }
          .filter { self.notifiedPokemons.map { $0.id }.contains($0.id) }
        guard watchlistedPokemons.count > 0 else {
          return
        }
        self.notifyPokemons(watchlistedPokemons)
    }.addDisposableTo(disposeBag)
  }
  
  func stop() {
    locationManager.stopUpdatingLocation()
    disposeBag = DisposeBag()
  }
  
  private func notifyPokemons(pokemons: [Pokemon]) {
    if pokemons.count == 1 {
      showNotification(pokemons[0])
    } else {
      showNotification(pokemons.count)
    }
  }
  
  private func showNotification(pokemon: Pokemon) {
    let notification = UILocalNotification()
    notification.alertBody = "\(pokemon.name) is nearby for another \(pokemon.expirationTime.shortTimeAgoSinceNow())"
    notification.fireDate = NSDate(timeIntervalSinceNow: 1)
    notification.timeZone = NSTimeZone.defaultTimeZone()
    UIApplication.sharedApplication().scheduleLocalNotification(notification)
  }
  
  private func showNotification(numberOfPokemon: Int) {
    let notification = UILocalNotification()
    notification.alertBody = "\(numberOfPokemon) Rare pokemons nearby!"
    notification.fireDate = NSDate(timeIntervalSinceNow: 1)
    notification.timeZone = NSTimeZone.defaultTimeZone()
    UIApplication.sharedApplication().scheduleLocalNotification(notification)
    
  }
  
  private static func loadPokemons(latitude: Double, longitude: Double) -> Observable<[Pokemon]> {
    return Network.request(API.Pokemons(latitude: latitude, longitude: longitude))
      .mapArray(Pokemon.self, key: "pokemon")
  }

}