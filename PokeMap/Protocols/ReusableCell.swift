//
//  ReusableCell.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

// This protocol assume your cell's identifier is the actual class name for the custom cell
// You can customize the reuseIdentifier by implementing the reuseIdentifier property.
protocol ReusableCell {

  var reuseIdentifier: String? { get }

}

extension ReusableCell where Self: UICollectionViewCell {

  var reuseIdentifier: String? {
    return Self.className
  }

}

extension ReusableCell where Self: UITableViewCell {

  var reuseIdentifier: String? {
    return Self.className
  }

}

extension UICollectionView {

  func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, index: Int) -> T {
    return dequeueReusableCell(type, indexPath: NSIndexPath(forItem: index, inSection: 0))
  }

  func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, indexPath: NSIndexPath) -> T {
    return dequeueReusableCellWithReuseIdentifier(T.className, forIndexPath: indexPath) as? T ?? T()
  }

}

extension UITableView {

  func dequeueReusableCell<T: UITableViewCell>(type: T.Type, index: Int) -> T {
    return dequeueReusableCell(type, indexPath: NSIndexPath(forRow: index, inSection: 0))
  }

  func dequeueReusableCell<T: UITableViewCell>(type: T.Type, indexPath: NSIndexPath) -> T {
    return dequeueReusableCellWithIdentifier(T.className, forIndexPath: indexPath) as? T ?? T()
  }

}
