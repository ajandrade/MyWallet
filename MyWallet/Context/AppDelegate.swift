//
//  AppDelegate.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow()
    
    let navigator = Navigator(window: window!)
    let persistanceService = PersistanceService()
    let presenter = AccountsListPresenter(persistanceService: persistanceService, navigator: navigator)
    let rootViewController = NavigationScene.accountsList(presenter)
    navigator.transition(to: rootViewController, type: .root)

    return true
  }


}

