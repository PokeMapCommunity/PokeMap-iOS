//
//  Pokemon.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct Pokemon: Mappable, Equatable {

  var pokemonId: Int!
  var expirationTime: NSDate!
  var latitude: Double!
  var longitude: Double!
  var isAlive: Bool!
  var uid: String!
  var identifier: Int!

  var imageURL: NSURL {
    return NSURL(string: "https://ugc.pokevision.com/images/pokemon/\((pokemonId as NSNumber).stringValue).png")!
  }

  var name: String {
    return PokedexHelper.sharedInstance.nameFromId((pokemonId as NSNumber).stringValue)
  }

  var expired: Bool {
    return expirationTime.compare(NSDate()) != .OrderedDescending
  }

  // MARK: JSON
  init?(_ map: Map) {
    let keys = ["id", "uid", "expiration_time", "pokemonId", "latitude", "longitude", "is_alive"]
    guard JSONHelper.containsKeys(map.JSONDictionary, keys: keys) else {
      print(map.JSONDictionary)
      return nil
    }
  }

  mutating func mapping(map: Map) {
    identifier <- map["id"]
    uid <- map["uid"]
    pokemonId <- map["pokemonId"]
    expirationTime <- (map["expiration_time"], EpochDateTransform())
    latitude <- map["latitude"]
    longitude <- map["longitude"]
    isAlive <- map["is_alive"]
  }
}

func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
  return lhs.identifier == rhs.identifier
}
