//
//  AccountsListViewController.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

class AccountsListViewController: UIViewController {
  
  // MARK: - DEPENDENCIES
  
  var presenter: AccountsListPresenterRepresentable!
  
  // MARK: - IBOUTLETS
  
  @IBOutlet fileprivate weak var tableView: UITableView! {
    didSet { tableView.register(AccountCell.self) }
  }

  // MARK: - VIEW LIFE CYCLE

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.accountsChanged = { [weak self] _ in
      self?.tableView.reloadData()
    }
  }
  
  // MARK: - IBACTIONS
  
  @IBAction func createNewAccount(_ sender: UIBarButtonItem) {
    presenter.createAccountPressed()
  }
  
}

extension AccountsListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.accountsNumber
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueCell(for: indexPath) as AccountCell
    let cellPresenter = presenter.getPresenter(for: indexPath.row)
    cell.configure(with: cellPresenter)
    return cell
  }
  
}

extension AccountsListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.accountSelected(at: indexPath.row)
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}
