//
//  UICollectionView + Rx.swift
//  Maya
//
//  Created by Майя Калицева on 18.07.2021.
//

import UIKit

extension UICollectionViewCell {

    static var reuseIdentifier: String { String(describing: Self.self) }
}

extension UICollectionView {

    func register<T: Reusable>(cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    func register<T: Reusable>(cellType: T.Type, bundle: Bundle?) {
        let nib = UINib(nibName: cellType.reuseIdentifier, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self).")
        }
        return cell
    }

    func register<T: Reusable>(viewType: T.Type) {
        register(viewType.self, forCellWithReuseIdentifier: viewType.reuseIdentifier)
    }

    func register<T: Reusable>(headerType: T.Type) {
        register(headerType, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerType.reuseIdentifier)
    }

    func dequeueReusableHeader<T: Reusable>(for indexPath: IndexPath, headerType: T.Type = T.self) -> T {
        guard let header = dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: headerType.reuseIdentifier, for: indexPath
        ) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(headerType.reuseIdentifier) matching type \(headerType.self).")
        }
        return header
    }
}

extension UICollectionView {

    func registerCells(withModels models: AnyCollectionViewCellModelProtocol.Type...) {
        models.forEach {
                register($0.cellClass, forCellWithReuseIdentifier: $0.reuseIdentifier)
        }
    }

    func dequeueReusableCell(withModel model: AnyCollectionViewCellModelProtocol, for indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: type(of: model).reuseIdentifier, for: indexPath)
    }

    func dequeueReusableCell(withModelType modelType: AnyCollectionViewCellModelProtocol.Type, for indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: modelType.reuseIdentifier, for: indexPath)
    }
}

protocol AnyCollectionViewCellModelProtocol: AnyCellViewModelProtocol {

    func configureAny(_ cell: UICollectionViewCell)
}

protocol CollectionViewCellModelProtocol: AnyCollectionViewCellModelProtocol {

    associatedtype CellType: UICollectionViewCell

    func configure(_ cell: CellType)
}

extension CollectionViewCellModelProtocol {

    static var cellClass: UIView.Type {
        return CellType.self
    }

    func configureAny(_ cell: UICollectionViewCell) {
        guard let cell = cell as? CellType else {
            assertionFailure()
            return
        }
        configure(cell)
    }
}
