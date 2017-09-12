//
//  String.swift
//  MyWallet
//
//  Created by Amadeu Andrade on 11/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

extension String {
  var accountNumberFormatting: String {
    var formattedString = ""
    for (index, character) in characters.enumerated() {
      if index % 4 < 3 || index == characters.count - 1 {
        formattedString.append(character)
      } else {
        formattedString.append("\(character) ")
      }
    }
    return formattedString
  }
}
