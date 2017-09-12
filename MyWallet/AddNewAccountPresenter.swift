//
//  AddNewAccountPresenter.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol AddNewAccountPresenterRepresentable {
  func dismiss()
  func save(accountName: String, bankName: String, accountNumber: String)
}

class AddNewAccountPresenter: AddNewAccountPresenterRepresentable {

  // MARK: - DEPENDENCIES
  
  private let navigator: NavigatorRepresentable
  private let persistanceService: PersistanceServiceRepresentable
  
  // MARK: - OUTPUT PROPERTIES
  
  var didAddAccount: (()-> Void)?
  
  // MARK: - INITIALIZER
  
  init(navigator: NavigatorRepresentable, persistanceService: PersistanceServiceRepresentable) {
    self.navigator = navigator
    self.persistanceService = persistanceService
  }
  
  // MARK: - METHODS
  
  func save(accountName: String, bankName: String, accountNumber: String) {
    var accounts = persistanceService.fetchAccounts()
    let newAccount = Account(name: accountName, bank: bankName, number: accountNumber, transactions: [])
    accounts.append(newAccount)
    persistanceService.save(accounts)
    didAddAccount?()
    dismiss()
  }
  
  // MARK: - NAVIGATION
  
  func dismiss() {
    navigator.dismiss()
  }

}
