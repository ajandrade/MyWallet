//
//  AccountCell.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {

  // MARK: - IBOUTLETS
  
  @IBOutlet private weak var cellContainerView: UIView! {
    didSet {
      cellContainerView.layer.cornerRadius = 5.0
    }
  }
  @IBOutlet private weak var accountNameLabel: UILabel!
  @IBOutlet private weak var accountBalanceLabel: UILabel!
  @IBOutlet private weak var bankNameLabel: UILabel!
  @IBOutlet private weak var accountNumberLabel: UILabel!
  
  // MARK: - INITIALIZATION
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - REUSE
  
  override func prepareForReuse() {
    accountNameLabel.text = ""
    accountBalanceLabel.text = ""
    accountNumberLabel.text = ""
    bankNameLabel.text = ""
    super.prepareForReuse()
  }
  
  // MARK: - CONFIGURATION
  
  func configure(with presenter: AccountCellPresenterRepresentable) {
    accountNameLabel.text = presenter.accountName
    accountBalanceLabel.text = presenter.accountBalance
    accountNumberLabel.text = presenter.accountNumber
    bankNameLabel.text = presenter.bankName
  }
  
}
