//
//  NSTimer+Rx.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift


extension NSTimer {
  /**
   Creates and schedules a one-time `NSTimer` instance.

   - Parameters:
   - delay: The delay before execution.
   - handler: A closure to execute after `delay`.

   - Returns: The newly-created `NSTimer` instance.
   */
  class func schedule(delay delay: NSTimeInterval, handler: NSTimer! -> Void) -> NSTimer {
    let fireDate = delay + CFAbsoluteTimeGetCurrent()
    let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
    return timer
  }

  /**
   Creates and schedules a repeating `NSTimer` instance.

   - Parameters:
   - repeatInterval: The interval (in seconds) between each execution of
   `handler`. Note that individual calls may be delayed; subsequent calls
   to `handler` will be based on the time the timer was created.
   - handler: A closure to execute at each `repeatInterval`.

   - Returns: The newly-created `NSTimer` instance.
   */
  class func schedule(repeatInterval interval: NSTimeInterval, handler: NSTimer! -> Void)
    -> NSTimer {
      let fireDate = interval + CFAbsoluteTimeGetCurrent()
      let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0,
                                                  handler)
      CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
      return timer
  }

  // swiftlint:disable variable_name
  class var rx_timer: Observable<Void> {
    return Observable<Void>.create { observer in
      observer.onNext()
      let timer = NSTimer.schedule(repeatInterval: 1.0) { timer in
        observer.onNext()
      }
      return AnonymousDisposable {
        observer.onCompleted()
        timer.invalidate()
      }
    }
  }
  // swiftlint:enable variable_name

}
