//
//  AccountDetailsViewController.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

class AccountDetailsViewController: UIViewController {

  // MARK: - DEPENDENCIES
  
  var presenter: AccountDetailsPresenterRepresentable!
  
  // MARK: - IBOUTLETS
  
  @IBOutlet private weak var navigationBar: UINavigationBar!
  @IBOutlet private weak var accountBalanceLabel: UILabel!
  @IBOutlet private weak var accountNumberLabel: UILabel!
  @IBOutlet private weak var tableView: UITableView! {
    didSet { tableView.register(AccountDetailCell.self) }
  }
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.topItem?.title = presenter.accountName
    accountNumberLabel.text = presenter.accountNumber
    accountBalanceLabel.text = presenter.accountBalance
  }
  
  // MARK: - IBACTIONS
  
  @IBAction func dismiss(_ sender: UIBarButtonItem) {
    presenter.dismiss()
  }
  
  @IBAction func createTransaction(_ sender: UIBarButtonItem) {
    
  }
  
}

extension AccountDetailsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.transactionsNumber
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueCell(for: indexPath) as AccountDetailCell
    let cellPresenter = presenter.cellPresenter(for: indexPath.row)
    cell.configure(with: cellPresenter)
    return cell
  }
  
}

extension AccountDetailsViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
  }
  
}
