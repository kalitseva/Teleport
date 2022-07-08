//
//  AnyCellItemProtocol.swift
//  
//
//
//

import UIKit
import RxDataSources

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

typealias AnyTableCellItem = AnyCellItem<AnyTableViewCellModelProtocol>
typealias AnyCollectionCellItem = AnyCellItem<AnyCollectionViewCellModelProtocol>

class AnyCellItem<T>: Equatable, IdentifiableType {
    let modelInstance: T
    let identity = UUID()

    init(_ model: T) {
        modelInstance = model
    }

    static func == (lhs: AnyCellItem, rhs: AnyCellItem) -> Bool {
        lhs.identity == rhs.identity
    }

    func configureAny(_ cell: UITableViewCell) {
        (modelInstance as? AnyTableViewCellModelProtocol)?.configureAny(cell)
    }

    func configureAny(_ cell: UICollectionViewCell) {
        (modelInstance as? AnyCollectionViewCellModelProtocol)?.configureAny(cell)
    }
}
