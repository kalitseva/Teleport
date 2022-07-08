//
//  String+SelectedSubstring.swift
//  VKComfort
//
//  Created by Denis Borodachenko on 05.10.2020.
//
import UIKit

extension String {

  func attributedText(divider: String, component: Int = 0, font: UIFont, selectedFont: UIFont, selectedColor: UIColor) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: self, attributes: [.font: font])
    let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: selectedFont, .foregroundColor: selectedColor]
    components(separatedBy: "\n").forEach { line in
      let boldString = (line as NSString).components(separatedBy: divider)[component]
      let range = component == 0 ? (self as NSString).range(of: "\(boldString)\(divider)") : (self as NSString).range(of: "\(boldString)")
      attributedString.addAttributes(boldFontAttribute, range: range)
    }
    return attributedString
  }
  
  func attributedSubstring(
    substring: String,
    font: UIFont,
    selectedFont: UIFont,
    selectedColor: UIColor = .noteLabelGrey,
    mainColor: UIColor = .almostBlack
  ) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: self, attributes: [.font: font, .foregroundColor: mainColor])
    let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: selectedFont, .foregroundColor: selectedColor]
    components(separatedBy: "\n").forEach { _ in
      let range = (self as NSString).range(of: substring)
      attributedString.addAttributes(boldFontAttribute, range: range)
    }
    return attributedString
  }
  
  func linkedSubstring(substring: String, fontSize: CGFloat = 13) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: self, attributes: [:])
    let linkedFontAttribute: [NSAttributedString.Key: Any] = [
      .underlineStyle: NSUnderlineStyle.single.rawValue,
      .font: UIFont.sfProRounded(ofSize: fontSize, weight: .semibold) ?? .systemFont(ofSize: fontSize)
    ]
    components(separatedBy: "\n").forEach { _ in
      let range = (self as NSString).range(of: substring)
      attributedString.addAttributes(linkedFontAttribute, range: range)
    }
    return attributedString
  }
  
  func doubleCardLabel(fontSize: CGFloat = 13) -> NSAttributedString {
    let contentFont = UIFont.sfProRounded(ofSize: fontSize) ?? .systemFont(ofSize: fontSize)
    let labelFont = UIFont.sfProRounded(ofSize: fontSize) ?? .boldSystemFont(ofSize: fontSize)
    return attributedText(divider: ":", font: contentFont, selectedFont: labelFont, selectedColor: .lightGrey)
  }
  
  func priceWithAmountLabel(fontSize: CGFloat = 15) -> NSAttributedString {
    let contentFont = UIFont.sfProRounded(ofSize: fontSize, weight: .semibold) ?? .systemFont(ofSize: fontSize)
    let labelFont = UIFont.sfProRounded(ofSize: fontSize, weight: .medium) ?? .boldSystemFont(ofSize: fontSize)
    return attributedText(divider: "₽", component: 1, font: contentFont, selectedFont: labelFont, selectedColor: .lightGrey)
  }
  
  func boldSubstring(substring: String, fontSize: CGFloat = 13) -> NSAttributedString {
    let contentFont = UIFont.sfProRounded(ofSize: fontSize) ?? .systemFont(ofSize: fontSize)
    let labelFont = UIFont.sfProRounded(ofSize: fontSize, weight: .semibold) ?? .boldSystemFont(ofSize: fontSize)
    return attributedSubstring(substring: substring, font: contentFont, selectedFont: labelFont)
  }
  
  func doubleAttachLabel(
    substring: String,
    firstFontSize: CGFloat = 15,
    secondFontSize: CGFloat = 13
  ) -> NSAttributedString {
    let contentFont = UIFont.sfProRounded(ofSize: firstFontSize) ?? .systemFont(ofSize: firstFontSize)
    let labelFont = UIFont.sfProRounded(ofSize: secondFontSize) ?? .boldSystemFont(ofSize: secondFontSize)
    return attributedSubstring(substring: substring, font: contentFont, selectedFont: labelFont, selectedColor: .lightGrey, mainColor: .noteLabelGrey)
  }
  
  func optionalAppendix(
    substring: String,
    firstFontSize: CGFloat = 15,
    secondFontSize: CGFloat = 13
  ) -> NSAttributedString {
    let contentFont = UIFont.sfProRounded(ofSize: firstFontSize, weight: .medium) ?? .systemFont(ofSize: firstFontSize)
    let labelFont = UIFont.sfProRounded(ofSize: secondFontSize, weight: .regular) ?? .boldSystemFont(ofSize: secondFontSize)
    return attributedSubstring(substring: substring, font: contentFont, selectedFont: labelFont, selectedColor: .lightGrey)
  }
  
  func coloredSubstring(
    substring: String,
    firstFontSize: CGFloat = 15,
    firstColor: UIColor = .lightGrey,
    secondFontSize: CGFloat = 15,
    secondColor: UIColor = .almostBlack
  ) -> NSAttributedString {
    let contentFont = UIFont.sfProRounded(ofSize: firstFontSize) ?? .systemFont(ofSize: firstFontSize)
    let labelFont = UIFont.sfProRounded(ofSize: secondFontSize) ?? .boldSystemFont(ofSize: secondFontSize)
    return attributedSubstring(substring: substring, font: contentFont, selectedFont: labelFont, selectedColor: secondColor, mainColor: firstColor)
  }
  
  func middleNameLabel(
    substring: String,
    firstFontSize: CGFloat = 15,
    secondFontSize: CGFloat = 13
  ) -> NSAttributedString {
    let contentFont = UIFont.sfProRounded(ofSize: firstFontSize, weight: .medium) ?? .systemFont(ofSize: firstFontSize)
    let labelFont = UIFont.sfProRounded(ofSize: secondFontSize, weight: .regular) ?? .boldSystemFont(ofSize: secondFontSize)
    return attributedSubstring(substring: substring, font: contentFont, selectedFont: labelFont, selectedColor: .lightGrey)
  }
  
  func agreeTermsLabel(
    substring: String,
    firstFontSize: CGFloat = 15,
    secondFontSize: CGFloat = 15
  ) -> NSAttributedString {
    let contentFont = UIFont.sfProRounded(ofSize: firstFontSize, weight: .regular) ?? .systemFont(ofSize: firstFontSize)
    let labelFont = UIFont.sfProRounded(ofSize: secondFontSize, weight: .semibold) ?? .boldSystemFont(ofSize: secondFontSize)
    return attributedSubstring(substring: substring, font: contentFont, selectedFont: labelFont, selectedColor: .urlsDarkBlue, mainColor: .accentBlue)
  }
  
  func phoneSubstring() -> NSAttributedString {
    let firstFontSize: CGFloat = 15
    let secondFontSize: CGFloat = 15
    let contentFont = UIFont.sfProRounded(ofSize: firstFontSize, weight: .regular) ?? .systemFont(ofSize: firstFontSize)
    let labelFont = UIFont.sfProRounded(ofSize: secondFontSize, weight: .regular) ?? .boldSystemFont(ofSize: secondFontSize)
    return attributedSubstring(substring: "+7 ", font: contentFont, selectedFont: labelFont, selectedColor: .black, mainColor: .noteLabelGrey)
  }
  // swiftlint:disable all
  func stripOutHtml() -> String? {
    do {
      guard let data = self.data(using: .unicode) else {
        return nil
      }
      let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
      return attributed.string
    } catch {
      return nil
    }
  }
}
