//
//  AccountsListPresenter.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol AccountsListPresenterRepresentable {
  var accountsNumber: Int { get }
  
  func getPresenter(for index: Int) -> AccountCellPresenterRepresentable
  
  func accountSelected(at index: Int)
  func createAccountPressed()
}

class AccountsListPresenter: AccountsListPresenterRepresentable {
  
  // MARK: - DEPENDENCIES
  
  private let persistanceService: PersistanceServiceRepresentable
  private let navigator: NavigatorRepresentable

  // MARK: - PRIVATE PROPERTIES
  
  private var accounts: [Account]
  private var accountPresenters: [AccountCellPresenterRepresentable]
  
  // MARK: - OUTPUT PROPERTIES
  
  var accountsNumber: Int { return accounts.count }

  // MARK: - INITIALIZER
  
  init(persistanceService: PersistanceServiceRepresentable, navigator: NavigatorRepresentable) {
    self.persistanceService = persistanceService
    self.navigator = navigator
    accounts = persistanceService.fetchAccounts()
    accountPresenters = accounts.map(AccountCellPresenter.init(account:))
  }
  
  // MARK: - NAVIGATION
  
  func accountSelected(at index: Int) {
    // TODO: - perform navigation
  }
  
  func createAccountPressed() {
    // TODO: - perform navigation
  }
  
  // MARK: - METHODS
  
  func getPresenter(for index: Int) -> AccountCellPresenterRepresentable {
    let presenter = accountPresenters[index]
    return presenter
  }

}
