//
//  Globals.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: Generic
class Globals {

  private static let userDefaults = NSUserDefaults.standardUserDefaults()

}


// MARK: User Defaults
extension Globals {

  static var watchlist: [String] {
    get {
      return userDefaults.stringArrayForKey("watchlist") ?? []
    }
    set {
      userDefaults.setObject(newValue, forKey: "watchlist")
      userDefaults.synchronize()
    }
  }
}
