//
//  WatchlistViewController.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WatchlistViewController: UIViewController {

  private let viewModel = PokemonWatchlistViewModel()

  @IBOutlet private weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.leftBarButtonItem =
      UIBarButtonItem(title: "Close", style: .Plain,
                      target: self,
                      action: #selector(WatchlistViewController.close))
    bindViewModel()
  }

  func close() {
    dismissViewControllerAnimated(true, completion: nil)
  }

  private func bindViewModel() {
    tableView.rx_setDelegate(self)
    viewModel.viewModels
      .bindTo(tableView.rx_itemsWithCellFactory) { (tableView, index, viewModel) in
        let cell = tableView.dequeueReusableCell(WatchlistTableViewCell.self, index: index)
        cell.viewModel = viewModel
        return cell
      }.addDisposableTo(rx_disposeBag)
  }
}

extension WatchlistViewController: UITableViewDelegate {

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    viewModel.watch(indexPath.row)
  }

  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    viewModel.unwatch(indexPath.row)
  }
}
