//
//  UICollectionView+Reusable.swift
//  
//
//
//

import UIKit

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

extension UICollectionViewCell: Reusable { }
