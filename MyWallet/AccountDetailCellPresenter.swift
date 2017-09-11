//
//  AccountDetailCellPresenter.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol AccountDetailCellPresenterRepresentable {
  var descriptionImageName: String { get }
  var date: String { get }
  var value: String { get }
  var description: String { get }
}

struct AccountDetailCellPresenter: AccountDetailCellPresenterRepresentable {
  
  // MARK: - PROPERTIES
  
  let descriptionImageName: String
  let date: String
  let value: String
  let description: String
  
  // MARK: - INITIALIZER
  
  init(transaction: Transaction) {
    descriptionImageName = transaction.category.imageName
    date = "\(transaction.date)"
    value = "$ \(transaction.amount)"
    description = transaction.description
  }
  
}
