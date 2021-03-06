//
//  AccountDetailsPresenter.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol AccountDetailsPresenterRepresentable {
  var didAddTransaction: (() -> Void)? { get set }

  var transactionsNumber: Int { get }
  var accountName: String { get }
  var accountBalance: String { get }
  var accountNumber: String { get }
  
  func cellPresenter(for index: Int) -> AccountDetailCellPresenterRepresentable
  
  func dismiss()
  func createTransaction()
  
}

class AccountDetailsPresenter: AccountDetailsPresenterRepresentable {
  
  // MARK: - DEPENDENCIES
  
  private let navigator: NavigatorRepresentable
  private let persistanceService: PersistanceServiceRepresentable
  private var account: Account
  
  // MARK: - PRIVATE PROPERTIES
  
  private var transactions: [Transaction]
  private var transactionPresenters: [AccountDetailCellPresenterRepresentable]
  
  // MARK: - OUTPUT PROPERTIES
  
  var accountName: String
  var accountBalance: String
  var accountNumber: String
  
  var transactionsNumber: Int {
    return transactions.count
  }
  
  var didAddTransaction: (() -> Void)?
  var reloadData: (() -> Void)?
  
  // MARK: - INITIALIZER
  
  init(navigator: NavigatorRepresentable, persistanceService: PersistanceServiceRepresentable, account: Account) {
    self.navigator = navigator
    self.persistanceService = persistanceService
    self.account = account
    accountName = account.name
    transactions = account.transactions
    accountBalance = "$ \(account.balance)"
    accountNumber = account.number.accountNumberFormatting
    transactionPresenters = transactions.map(AccountDetailCellPresenter.init(transaction:))
  }
  
  // MARK: - METHODS
  
  func cellPresenter(for index: Int) -> AccountDetailCellPresenterRepresentable {
    let presenter = transactionPresenters[index]
    return presenter
  }
  
  // MARK: - NAVIGATION
  
  func dismiss() {
    reloadData?()
    navigator.pop()
  }
  
  func createTransaction() {
    let createTransactionPresenter = AddNewTransactionPresenter(navigator: navigator, persistanceService: persistanceService, account: account)
    createTransactionPresenter.didFinishSaving = { [weak self] _ in self?.updateModel() }
    let createTransactionViewController = NavigationScene.newTransaction(createTransactionPresenter)
    navigator.transition(to: createTransactionViewController, type: .modal)
  }
  
  // MARK: - METHODS
  
  private func updateModel() {
    guard let updatedAccount = persistanceService.getAccount(with: account.number) else { return }
    self.account = updatedAccount
    accountName = updatedAccount.name
    transactions = updatedAccount.transactions
    accountBalance = "$ \(updatedAccount.balance)"
    accountNumber = updatedAccount.number.accountNumberFormatting
    transactionPresenters = transactions.map(AccountDetailCellPresenter.init(transaction:))
    didAddTransaction?()
  }
  
}
