//
//  Array+Unique.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

  func arrayByAppendingContentsOf(elements: Array<Element>) -> Array<Element> {
    return self + elements
  }

  /// Returns only the unique elements out of an array
  var unique: [Element] {
    var uniqueValues: [Element] = []
    forEach { item in
      if !uniqueValues.contains(item) {
        uniqueValues += [item]
      }
    }
    return uniqueValues
  }
}
