//
//  PersistanceService.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol PersistanceServiceRepresentable {
  func save(_ account: Account)
  func save(_ items: [Account])
  func fetchAccounts() -> [Account]
  func update(_ account: Account, with transaction: Transaction)
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
      Account(name: "Account 1", bank: "Bank 1", number: "01234567890123456789", transactions: [incomeTransaction, transportTransaction, funTransaction]),
      Account(name: "Account 2", bank: "Bank 2", number: "82748124718248124612", transactions: [incomeTransaction, transportTransaction, funTransaction]),
      Account(name: "Account 3", bank: "Bank 3", number: "42942948294729475215", transactions: [incomeTransaction, transportTransaction, funTransaction]),
      Account(name: "Account 4", bank: "Bank 4", number: "59175917259125912759", transactions: [incomeTransaction, transportTransaction, funTransaction]),
      Account(name: "Account 5", bank: "Bank 5", number: "51581975817950464434", transactions: [incomeTransaction, transportTransaction, funTransaction])
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
    return accountsPlist.map(Account.init(plist:)).sorted(by: { $0.name < $1.name })
  }
  
  func save(_ account: Account) {
    var accounts = fetchAccounts()
    accounts.append(account)
    save(accounts)
  }
  
  func update(_ account: Account, with transaction: Transaction) {
    var accounts = fetchAccounts().filter { $0.number != account.number }
    var accountTransactions = account.transactions
    accountTransactions.append(transaction)
    let updatedAccount = Account(name: account.name, bank: account.bank, number: account.number, transactions: accountTransactions)
    accounts.append(updatedAccount)
    save(accounts)
  }
  
}
