//
//  AddNewAccountViewController.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

class AddNewAccountViewController: UIViewController {

  // MARK: - DEPENDENCIES
  
  var presenter: AddNewAccountPresenterRepresentable!
  
  // MARK: - IBOUTLETS
  
  @IBOutlet fileprivate weak var accountNameTextField: UITextField! {
    didSet { accountNameTextField.becomeFirstResponder() }
  }
  @IBOutlet fileprivate weak var bankNameTextField: UITextField!
  @IBOutlet fileprivate weak var accountNumberTextField: UITextField!
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - IBACTIONS
  
  @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
    presenter.dismiss()
  }
  
  @IBAction func savePressed(_ sender: UIBarButtonItem) {
    guard let accountName = accountNameTextField.text, let bankName = bankNameTextField.text, let accountNumber = accountNumberTextField.text else { return }
    view.endEditing(true)
    presenter.save(accountName: accountName, bankName: bankName, accountNumber: accountNumber)
  }
  
}

extension AddNewAccountViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case accountNameTextField:
      bankNameTextField.becomeFirstResponder()
    case bankNameTextField:
      accountNumberTextField.becomeFirstResponder()
    default:
      view.endEditing(true)
    }
    return false
  }
  
  
}
