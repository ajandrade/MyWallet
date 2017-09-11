//
//  AccountsListPresenter.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol AccountsListPresenterRepresentable { }

class AccountsListPresenter: AccountsListPresenterRepresentable {
  
  // MARK: - DEPENDENCIES
  
  private let persistanceService: PersistanceServiceRepresentable
  private let navigator: NavigatorRepresentable

  // MARK: - INITIALIZER
  
  init(persistanceService: PersistanceServiceRepresentable, navigator: NavigatorRepresentable) {
    self.persistanceService = persistanceService
    self.navigator = navigator
  }

}
