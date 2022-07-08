//
//  String+Digits.swift
//  VKComfort
//
//  Created by Kirill Zhadaev on 03.12.2020.
//

import Foundation

extension String {
  var digits: String {
    components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
  }
  
  var formatedPhone: String { format(with: "+X (XXX) XXX-XX-XX") }
  
  private func format(with mask: String) -> String {
    let numbers = replacingOccurrences(
      of: "[^0-9]",
      with: "",
      options: .regularExpression)
    var result = ""
    var index = numbers.startIndex
    
    for ch in mask where index < numbers.endIndex {
      if ch == "X" {
        result.append(numbers[index])
        index = numbers.index(after: index)
        
      } else {
        result.append(ch)
      }
    }
    return result
  }
  
  func getAllIntFromString() -> Int? {
    let number = Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    return number
  }
  
  var isEmail: Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: self)
  }
  
  func isValidPhone(phone: String) -> Bool {
    let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    return phoneTest.evaluate(with: phone)
  }
}

extension NSAttributedString {

   convenience init?(html: String) {
    guard let data = html.data(using: .utf16, allowLossyConversion: false) else { return nil }

    func mutableString() -> NSMutableAttributedString? {
      return try? NSMutableAttributedString(data: data, options: [.documentType: Self.DocumentType.html], documentAttributes: nil)
    }

    guard let attributedString = mutableString() else {
      return nil
    }

    self.init(attributedString: attributedString)
  }
}
