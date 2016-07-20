//
//  UITableViewHeaderFooterView+Rx.swift
//  Pods
//
//  Created by sergdort on 5/11/16.
//
//

import UIKit
import ObjectiveC
import RxSwift

extension UITableViewHeaderFooterView {    
    func rx_prepareForReuse() {
        self.rx_prepareForReuse()
        rx_reusableDisposeBag = DisposeBag()
    }
    
    public override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }
        // make sure this isn't a subclass
        if self !== UITableViewHeaderFooterView.self {
            return
        }
        dispatch_once(&Static.token) {
            self.swizzleMethodForSelector(#selector(self.prepareForReuse),
                                          withMethodForSelector: #selector(self.rx_prepareForReuse))
        }
    }
}
