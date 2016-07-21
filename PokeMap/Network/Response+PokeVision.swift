//
//  Response+PokeVision.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift

extension Response {

  func mapObject<T: Mappable>(type: T.Type, key: String) throws -> T {
    let json = try mapJSON()

    guard let value = json[key] as? String, object = Mapper<T>().map(value) else {
      throw Error.JSONMapping(self)
    }

    return object
  }

  func mapArray<T: Mappable>(type: T.Type, key: String) throws -> [T] {
    let json = try mapJSON()

    guard let value = json[key] as? [AnyObject], objects = Mapper<T>().mapArray(value) else {
      throw Error.JSONMapping(self)
    }

    return objects
  }

}


extension ObservableType where E == Response {

  func mapObject<T: Mappable>(type: T.Type, key: String) -> Observable<T> {
    return flatMap { response -> Observable<T> in
      return Observable.just(try response.mapObject(type, key: key))
    }
  }

  func mapArray<T: Mappable>(type: T.Type, key: String) -> Observable<[T]> {
    return flatMap { response -> Observable<[T]> in
      return Observable.just(try response.mapArray(type, key: key))
    }
  }
}
