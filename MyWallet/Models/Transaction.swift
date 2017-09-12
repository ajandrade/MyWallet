//
//  Transaction.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

enum TransactionCategory: String {
  case income, groceries, utilities, home, transport, fun
  
  var imageName: String {
    return self.rawValue
  }
}

struct Transaction {
  
  fileprivate enum TransactionKey: String {
    case amount, description, date, category
    var key: String { return self.rawValue }
  }
  
  let amount: Float
  let description: String
  let date: Date
  let category: TransactionCategory
  
}

extension Transaction: PlistRepresentable {
  
  var plistRepresentation: PlistData {
    return [
      TransactionKey.amount.key : amount,
      TransactionKey.description.key : description,
      TransactionKey.date.key : date,
      TransactionKey.category.key : category.rawValue
    ]
  }
  
  init(plist: PlistData) {
    amount = plist[TransactionKey.amount.key] as! Float
    description = plist[TransactionKey.description.key] as! String
    date = plist[TransactionKey.date.key] as! Date
    category = TransactionCategory(rawValue: plist[TransactionKey.category.key] as! String)!
  }
  
}
