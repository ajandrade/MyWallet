//
//  AccountDetailsPresenter.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol AccountDetailsPresenterRepresentable {
  var transactionsNumber: Int { get }
  var accountName: String { get }
  var accountBalance: String { get }
  var accountNumber: String { get }
  
  func cellPresenter(for index: Int) -> AccountDetailCellPresenterRepresentable
  
  func dismiss()
  
}

class AccountDetailsPresenter: AccountDetailsPresenterRepresentable {
  
  // MARK: - DEPENDENCIES
  
  private let navigator: NavigatorRepresentable
  private let account: Account
  
  // MARK: - PRIVATE PROPERTIES
  
  private let transactions: [Transaction]
  private let transactionPresenters: [AccountDetailCellPresenterRepresentable]
  
  // MARK: - OUTPUT PROPERTIES
  
  let accountName: String
  let accountBalance: String
  let accountNumber: String
  
  var transactionsNumber: Int {
    return transactions.count
  }
  
  // MARK: - INITIALIZER
  
  init(navigator: NavigatorRepresentable, account: Account) {
    self.navigator = navigator
    self.account = account
    accountName = account.name
    transactions = account.transactions
    accountBalance = "$ \(account.balance)"
    accountNumber = account.number
    transactionPresenters = transactions.map(AccountDetailCellPresenter.init(transaction:))
  }
  
  // MARK: - METHODS
  
  func cellPresenter(for index: Int) -> AccountDetailCellPresenterRepresentable {
    let presenter = transactionPresenters[index]
    return presenter
  }
  
  // MARK: - NAVIGATION
  
  func dismiss() {
    navigator.pop()
  }
  
  func createTransaction() {

  }
  
}
