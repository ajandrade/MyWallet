//
//  PersistanceService.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol PersistanceServiceRepresentable {
  func save(_ items: [Account])
  func fetchAccounts() -> [Account]
}

class PersistanceService {
  
  // MARK: - PRIVATE PROPERTIES
  
  fileprivate let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  
  fileprivate var accountsFileURL: URL {
    return documentsDirectoryURL
      .appendingPathComponent("Accounts")
      .appendingPathExtension("plist")
  }
  
  // MARK: - HELPERS
  
  fileprivate func createFakeData() -> [Account] {
    let incomeTransaction = Transaction(amount: 1234.26, description: "Some work", date: Date(), category: .income)
    let transportTransaction = Transaction(amount: 50, description: "Bus", date: Date(), category: .transport)
    let funTransaction = Transaction(amount: 21.44, description: "Bar", date: Date(), category: .fun)
    let accounts = [
      Account(name: "Account Name", bank: "Bank Name", number: "01234567890123456789", transactions: [incomeTransaction, transportTransaction, funTransaction]),
      Account(name: "Account Name", bank: "Bank Name", number: "01234567890123456789", transactions: [incomeTransaction, transportTransaction, funTransaction]),
      Account(name: "Account Name", bank: "Bank Name", number: "01234567890123456789", transactions: [incomeTransaction, transportTransaction, funTransaction]),
      Account(name: "Account Name", bank: "Bank Name", number: "01234567890123456789", transactions: [incomeTransaction, transportTransaction, funTransaction]),
      Account(name: "Account Name", bank: "Bank Name", number: "01234567890123456789", transactions: [incomeTransaction, transportTransaction, funTransaction])
    ]
    save(accounts)
    return accounts
  }
  
}

extension PersistanceService: PersistanceServiceRepresentable {

  func save(_ accounts: [Account]) {
    let accountsPlist = accounts.map { $0.plistRepresentation } as NSArray
    accountsPlist.write(to: accountsFileURL, atomically: true)
  }
  
  func fetchAccounts() -> [Account] {
    guard let accountsPlist = NSArray(contentsOf: accountsFileURL) as? [PlistData] else {
      return createFakeData()
    }
    return accountsPlist.map(Account.init(plist:))
  }
}
