//
//  UITableViewCell+Reusable.swift
//  TableDS
//
//  Created by Elina Efremova on 16.12.2020.
//

import UIKit

extension UITableViewCell {

    static var reuseIdentifier: String { String(describing: Self.self) }
}
