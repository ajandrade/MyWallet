//
//  AddNewTransactionViewController.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

class AddNewTransactionViewController: UIViewController {

  // MARK: - DEPENDENCIES
  
  var presenter: AddNewTransactionPresenterRepresentable!
  
  // MARK: - IBOUTLETS
  
  @IBOutlet private weak var valueTextField: UITextField!
  @IBOutlet private weak var descriptionTextField: UITextField!
  @IBOutlet private weak var incomeButton: UIButton!
  @IBOutlet private weak var groceriesButton: UIButton!
  @IBOutlet private weak var utilitiesButton: UIButton!
  @IBOutlet private weak var homeButton: UIButton!
  @IBOutlet private weak var transportButton: UIButton!
  @IBOutlet private weak var funButton: UIButton!

  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setVisible(.income)
  }
  
  // MARK: - IBACTIONS
  
  @IBAction func transactionTypePressed(_ sender: UIButton) {
    switch sender.tag {
    case 1:
      setVisible(.groceries)
    case 2:
      setVisible(.utilities)
    case 3:
      setVisible(.home)
    case 4:
      setVisible(.transport)
    case 5:
      setVisible(.fun)
    default:
      setVisible(.income)
    }
  }
  
  @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
    presenter.dismiss()
  }

  @IBAction func savePressed(_ sender: UIBarButtonItem) {
    guard let value = valueTextField.text, value != "", let description = descriptionTextField.text, description != "" else { return }
    view.endEditing(true)
    presenter.save(amount: value, description: description)
  }
  
  // MARK: - METHODS

  private func setVisible(_ type: TransactionCategory) {
    presenter.setTransactionType(type)
    switch type {
    case .income:
      incomeButton.alpha = 1.0
      groceriesButton.alpha = 0.3
      utilitiesButton.alpha = 0.3
      homeButton.alpha = 0.3
      transportButton.alpha = 0.3
      funButton.alpha = 0.3
    case .groceries:
      groceriesButton.alpha = 1.0
      incomeButton.alpha = 0.3
      utilitiesButton.alpha = 0.3
      homeButton.alpha = 0.3
      transportButton.alpha = 0.3
      funButton.alpha = 0.3
    case .fun:
      funButton.alpha = 1.0
      groceriesButton.alpha = 0.3
      utilitiesButton.alpha = 0.3
      homeButton.alpha = 0.3
      transportButton.alpha = 0.3
      incomeButton.alpha = 0.3
    case .home:
      homeButton.alpha = 1.0
      groceriesButton.alpha = 0.3
      utilitiesButton.alpha = 0.3
      incomeButton.alpha = 0.3
      transportButton.alpha = 0.3
      funButton.alpha = 0.3
    case .transport:
      transportButton.alpha = 1.0
      groceriesButton.alpha = 0.3
      utilitiesButton.alpha = 0.3
      homeButton.alpha = 0.3
      incomeButton.alpha = 0.3
      funButton.alpha = 0.3
    case .utilities:
      utilitiesButton.alpha = 1.0
      groceriesButton.alpha = 0.3
      incomeButton.alpha = 0.3
      homeButton.alpha = 0.3
      transportButton.alpha = 0.3
      funButton.alpha = 0.3
    }
  }

}
