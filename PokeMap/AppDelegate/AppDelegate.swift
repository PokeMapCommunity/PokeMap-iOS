//
//  AppDelegate.swift
//  PokeMap
//
//  Created by Ivan Bruel on 20/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    Fabric.with([Crashlytics.self])
    UIApplication.sharedApplication()
      .setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
    application
      .registerUserNotificationSettings(UIUserNotificationSettings(forTypes:
        [.Alert, .Badge, .Sound], categories: nil))
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    LocationHelper.sharedInstance.start()
  }

  func applicationDidEnterBackground(application: UIApplication) {

  }

  func applicationWillEnterForeground(application: UIApplication) {
    LocationHelper.sharedInstance.stop()
  }

  func applicationDidBecomeActive(application: UIApplication) {
  }

  func applicationWillTerminate(application: UIApplication) {
  }


}
