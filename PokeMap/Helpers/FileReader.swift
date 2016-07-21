//
//  FileReader.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

class FileReader {

  class func readFileData(filename: String, fileExtension: String) -> NSData {
    if let path = NSBundle(forClass: self).pathForResource(filename, ofType: fileExtension) {
      do {
        let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path),
                              options: NSDataReadingOptions.DataReadingMappedIfSafe)
        return data
      } catch let error as NSError {
        print(error.localizedDescription)
      }
    } else {
      print("Could not find file: \(filename).\(fileExtension)")
    }
    return NSData()
  }

  class func readFileString(filename: String, fileExtension: String) -> String {
    return String(data: readFileData(filename, fileExtension: fileExtension),
                  encoding: NSUTF8StringEncoding) ?? ""
  }
}
