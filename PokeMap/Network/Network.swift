//
//  Network.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class Network {

  private static var provider = RxMoyaProvider<API>(endpointClosure: {
    target -> Endpoint<API> in
    return Endpoint<API>(URL: target.url,
      sampleResponseClosure: { .NetworkResponse(200, target.sampleData) },
      method: target.method,
      parameters: target.parameters,
      parameterEncoding: target.parameterEncoding,
      httpHeaderFields: target.headers)
    }, plugins: [
      NetworkLoggerPlugin(cURL: true)
    ])
}

// MARK: Public Methods
extension Network {

  static func request(target: API) -> Observable<Response> {
    return provider.request(target)
  }
}
