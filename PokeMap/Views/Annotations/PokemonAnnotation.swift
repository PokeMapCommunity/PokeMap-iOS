//
//  PokemonAnnotation.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import MapKit
import SDWebImage

class PokemonAnnotation: NSObject, MKAnnotation {

  let coordinate: CLLocationCoordinate2D
  let identifier: String
  let title: String?
  var subtitle: String?
  let expiration: NSDate
  let imageURL: NSURL

  init(coordinate: CLLocationCoordinate2D, identifier: String, title: String, expiration: NSDate,
       imageURL: NSURL) {
      self.coordinate = coordinate
    self.identifier = identifier
    self.title = title
    self.subtitle = nil
    self.expiration = expiration
    self.imageURL = imageURL
  }

  var expired: Bool {
    return expiration.compare(NSDate()) != .OrderedDescending
  }

  var annotationView: MKAnnotationView {
    let annotationView = MKAnnotationView(annotation: self, reuseIdentifier: "PokemonAnnotation")
    annotationView.enabled = true
    annotationView.canShowCallout = true
    annotationView.sd_setImageWithURL(imageURL)
    return annotationView
  }
}
