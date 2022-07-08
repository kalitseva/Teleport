//
//  UITableView + Rx.swift
//  Maya
//
//  Created by Майя Калицева on 17.07.2021.
//

import UIKit
import RxDataSources

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: Reusable { }


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

extension UITableView {

    func registerCells(withModels models: AnyTableViewCellModelProtocol.Type...) {
        models.forEach {
            register(cellType: $0.cellClass)
        }
    }

    func dequeueReusableCell(withModel model: AnyTableViewCellModelProtocol, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: type(of: model).reuseIdentifier, for: indexPath)
    }

    func dequeueReusableCell(withModelType modelType: AnyTableViewCellModelProtocol.Type, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: modelType.reuseIdentifier, for: indexPath)
    }
}


protocol AnyTableViewCellModelProtocol: AnyCellViewModelProtocol {

    func configureAny(_ cell: UITableViewCell)
}

protocol TableViewCellModelProtocol: AnyTableViewCellModelProtocol {

    associatedtype CellType: UITableViewCell

    var height: CGFloat { get }

    func configure(_ cell: CellType)
}

extension TableViewCellModelProtocol {
    var height: CGFloat { 0 }
}

extension TableViewCellModelProtocol {

    static var cellClass: UIView.Type {
        return CellType.self
    }

    func configureAny(_ cell: UITableViewCell) {
        guard let cell = cell as? CellType else {
            assertionFailure()
            return
        }
        configure(cell)
    }
}

protocol AnyCellViewModelProtocol: class {

    static var cellClass: UIView.Type { get }
    static var reuseIdentifier: String { get }
}

extension AnyCellViewModelProtocol {

    private static var cellClassName: String {
        return String(describing: cellClass)
    }

    static var reuseIdentifier: String {
        return cellClassName
    }
}

extension UITableViewCell {

    static var reuseIdentifier: String { String(describing: Self.self) }
}




