//
//  AddNewTransactionPresenter.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol AddNewTransactionPresenterRepresentable {
  func setTransactionType(_ type: TransactionCategory)
  func dismiss()
  func save(amount: String, description: String)
}

class AddNewTransactionPresenter: AddNewTransactionPresenterRepresentable {
  
  // MARK: - DEPENDENCIES
  
  private let navigator: NavigatorRepresentable
  private let persistanceService: PersistanceServiceRepresentable
  private let account: Account
  
  // MARK: - PRIVATE PROPERTIES
  
  private var transactionType: TransactionCategory = .income
  
  // MARK: - OUTPUT PROPERTIES
  
  var didFinishSaving: ((Transaction)-> Void)?
  
  // MARK: - INITIALIZER
  
  init(navigator: NavigatorRepresentable, persistanceService: PersistanceServiceRepresentable, account: Account) {
    self.navigator = navigator
    self.persistanceService = persistanceService
    self.account = account
  }
  
  // MARK: - METHODS
  
  func setTransactionType(_ type: TransactionCategory) {
    transactionType = type
  }
  
  func save(amount: String, description: String) {
    let transaction = Transaction(amount: Float(amount) ?? 0, description: description, date: Date(), category: transactionType)
    persistanceService.update(account, with: transaction)
    didFinishSaving?(transaction)
    dismiss()
  }
  
  // MARK: - NAVIGATION
  
  func dismiss() {
    navigator.dismiss()
  }

}
