//
//  Account.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

struct Account {
  
  fileprivate enum AccountKey: String {
    case name, bank, number, transactions
    var key: String { return self.rawValue }
  }
  
  let name: String
  let bank: String
  let number: String
  var transactions: [Transaction]
  
  var balance: Float {
    return transactions.reduce(0.0, { $0 + $1.amount * ($1.category == .income ? 1 : -1) })
  }
  
}

extension Account: PlistRepresentable {
  
  var plistRepresentation: PlistData {
    return [
      AccountKey.name.key: name,
      AccountKey.bank.key : bank,
      AccountKey.number.key : number,
      AccountKey.transactions.key : transactions.map { $0.plistRepresentation }
    ]
  }
  
  init(plist: PlistData) {
    name = plist[AccountKey.name.key] as! String
    bank = plist[AccountKey.bank.key] as! String
    number = plist[AccountKey.number.key] as! String
    let transactionsList = plist[AccountKey.transactions.key] as! [[String:Any]]
    transactions = transactionsList.map(Transaction.init(plist:))
  }
  
}
