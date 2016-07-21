//
//  EpochDateTransform.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

class EpochDateTransform: TransformType {
  typealias Object = NSDate
  typealias JSON = Int

  init() {}

  func transformFromJSON(value: AnyObject?) -> Object? {
    guard let value = value as? Int else {
      return nil
    }
    return NSDate(timeIntervalSince1970: Double(value))
  }

  func transformToJSON(value: Object?) -> JSON? {
    return value.flatMap { Int($0.timeIntervalSince1970) }
  }
}
