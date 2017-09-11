//
//  AccountsListPresenter.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol AccountsListPresenterRepresentable {
  var accountsChanged: (()-> Void)? { get set }
  var accountsNumber: Int { get }
  
  func cellPresenter(for index: Int) -> AccountCellPresenterRepresentable
  
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
  
  var accountsChanged: (()-> Void)?
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
    let account = accounts[index]
    let detailsPresenter = AccountDetailsPresenter(navigator: navigator, persistanceService: persistanceService, account: account)
    detailsPresenter.didAddTransaction = { [weak self] _ in self?.updateModels() }
    let detailsViewController = NavigationScene.accountDetails(detailsPresenter)
    navigator.transition(to: detailsViewController, type: .push)
  }
  
  func createAccountPressed() {
    let createAccountPresenter = AddNewAccountPresenter(navigator: navigator, persistanceService: persistanceService)
    createAccountPresenter.didFinishSaving = { [weak self] _ in self?.updateModels() }
    let createAccountViewController = NavigationScene.newAccount(createAccountPresenter)
    navigator.transition(to: createAccountViewController, type: .modal)
  }
  
  // MARK: - METHODS
  
  private func updateModels() {
    accounts = persistanceService.fetchAccounts()
    accountPresenters = accounts.map(AccountCellPresenter.init(account:))
    accountsChanged?()
  }
  
  func cellPresenter(for index: Int) -> AccountCellPresenterRepresentable {
    let presenter = accountPresenters[index]
    return presenter
  }

}
