//
//  Job.swift
//  PokeMap
//
//  Created by Ivan Bruel on 21/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct ScanJob: Mappable {

  var status: String!
  var jobId: String!

  // MARK: JSON
  init?(_ map: Map) {
    let keys = ["status", "jobId"]
    guard JSONHelper.containsKeys(map.JSONDictionary, keys: keys) else {
      print(map.JSONDictionary)
      return nil
    }
  }

  mutating func mapping(map: Map) {
    status <- map["status"]
    jobId <- map["jobId"]
  }
}
