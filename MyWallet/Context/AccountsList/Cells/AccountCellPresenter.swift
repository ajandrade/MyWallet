//
//  AccountCellPresenter.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol AccountCellPresenterRepresentable {
  var accountName: String { get }
  var accountBalance: String { get }
  var accountNumber: String { get }
  var bankName: String { get }
}

struct AccountCellPresenter: AccountCellPresenterRepresentable {

  // MARK: - PROPERTIES
  
  let accountName: String
  let accountBalance: String
  let accountNumber: String
  let bankName: String
  
  // MARK: - INITIALIZER
  
  init(account: Account) {
    accountName = account.name
    accountNumber = account.number.accountNumberFormatting
    accountBalance = "$ \(account.balance)"
    bankName = account.bank
  }
  
}
