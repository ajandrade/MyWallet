//
//  NavigationScene.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

enum NavigationScene {
  case accountsList(AccountsListPresenterRepresentable)
}

extension NavigationScene {
  
  func viewController() -> UIViewController {
    switch self {
    case .accountsList(let presenter):
      let accountsViewController = AccountsListViewController()
      accountsViewController.presenter = presenter
      return accountsViewController
    }
  }
  
}
