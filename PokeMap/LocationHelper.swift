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
  
  init() {
    locationManager = CLLocationManager()
    
  }
  
  func start() {
    locationManager.startUpdatingLocation()
    locationManager.rx_didUpdateLocations
      .debug()
      //.throttle(2, scheduler: SerialDispatchQueueScheduler(internalSerialQueueName: "LocationUpdate"))
      .map { $0.first }
      .debug()
      .filterNil()
      .flatMap { location in
        LocationHelper.loadPokemons(location.coordinate.latitude,
          longitude: location.coordinate.longitude)
      }.subscribeNext { pokemons in
        self.notifyPokemons(pokemons)
    }.addDisposableTo(disposeBag)
  }
  
  func stop() {
    locationManager.stopUpdatingLocation()
    disposeBag = DisposeBag()
  }
  
  private func notifyPokemons(pokemons: [Pokemon]) {
    let watchlistedPokemons = pokemons.filter { Globals.watchlist.contains($0.id) }
    if watchlistedPokemons.count == 1 {
      showNotification(watchlistedPokemons[0])
    } else {
      showNotification(watchlistedPokemons.count)
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
    notification.alertBody = "\(numberOfPokemon) Pokemons nearby!"
    notification.fireDate = NSDate(timeIntervalSinceNow: 1)
    notification.timeZone = NSTimeZone.defaultTimeZone()
    UIApplication.sharedApplication().scheduleLocalNotification(notification)
    
  }
  
  private static func loadPokemons(latitude: Double, longitude: Double) -> Observable<[Pokemon]> {
    return Network.request(API.Pokemons(latitude: latitude, longitude: longitude))
      .mapArray(Pokemon.self, key: "pokemon")
  }

}