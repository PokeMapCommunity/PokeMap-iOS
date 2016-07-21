//
//  JSONReader.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONReader {

  class func readFromJSON<T: Mappable>(filename: String) -> T? {
    return Mapper<T>().map(JSONReader.readJSONString(filename))
  }

  class func readJSONString(filename: String) -> String? {
    return String(data: readJSONData(filename), encoding: NSUTF8StringEncoding)
  }

  class func readJSONData(filename: String) -> NSData {
    return FileReader.readFileData(filename, fileExtension: "json")
  }

  class func readJSONDictionary(filename: String) -> [String: String] {
    do {
      return try NSJSONSerialization.JSONObjectWithData(readJSONData(filename),
                                                        options: []) as? [String: String] ?? [:]
    } catch let error as NSError {
      print(error)
      return [:]
    }
  }

}
