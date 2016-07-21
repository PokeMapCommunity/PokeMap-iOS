//
//  WatchlistTableViewCell.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import SDWebImage
import Cell_Rx

class WatchlistTableViewCell: UITableViewCell, ReusableCell {

  @IBOutlet private weak var pokemonImageView: UIImageView!
  @IBOutlet private weak var nameLabel: UILabel!

  var viewModel: PokemonWatchlistItemViewModel? {
    didSet {
      if let viewModel = viewModel {
        pokemonImageView.sd_setImageWithURL(viewModel.imageURL)
        nameLabel.text = viewModel.text
        viewModel.watched.asObservable()
          .subscribeNext { [weak self] watched in
          self?.accessoryType = watched ? .Checkmark : .None
        }.addDisposableTo(rx_reusableDisposeBag)
      }
    }
  }
}
