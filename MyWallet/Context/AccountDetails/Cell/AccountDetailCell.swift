//
//  AccountDetailCell.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

class AccountDetailCell: UITableViewCell {

  // MARK: - IBOUTLETS
  
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var valueLabel: UILabel!
  @IBOutlet private weak var descriptionImageView: UIImageView!
  
  // MARK: - INITIALIZATION
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - REUSE
  
  override func prepareForReuse() {
    descriptionLabel.text = ""
    dateLabel.text = ""
    valueLabel.text = ""
    descriptionImageView.image = nil
    super.prepareForReuse()
  }
  
  // MARK: - CONFIGURATION
  
  func configure(with presenter: AccountDetailCellPresenterRepresentable) {
    descriptionLabel.text = presenter.description
    descriptionImageView.image = UIImage(named: presenter.descriptionImageName)
    valueLabel.text = presenter.value
    dateLabel.text = presenter.date
  }
  
}
