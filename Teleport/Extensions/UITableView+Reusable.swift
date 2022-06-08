//
//  UITableView+Reusable.swift
//
//
//  Created by Maya Kalitseva on 07.04.2021.
//

import UIKit

extension UITableView {

    func register<T: Reusable>(cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    func register<T: Reusable>(cellType: T.Type, bundle: Bundle?) {
        let nib = UINib(nibName: cellType.reuseIdentifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self).")
        }
        return cell
    }

    func register<T: Reusable>(viewType: T.Type) {
        register(viewType.self, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
    }

    func dequeueReusableHeaderFooterView<T: Reusable>() -> T {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(T.reuseIdentifier) matching type \(T.self).")
        }
        return headerFooter
    }
}

extension UITableViewCell: Reusable { }

extension UITableViewHeaderFooterView: Reusable { }
