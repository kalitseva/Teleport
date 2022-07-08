//
//  UICollectionView+Reusable.swift
//  
//
//
//

import UIKit

extension UICollectionView {

  func registerCellFromNib(cell: UICollectionViewCell.Type) {
    register(cell.nib, forCellWithReuseIdentifier: cell.nibName)
  }
  
  func registerHeaderFromNib(cell: UICollectionViewCell.Type) {
    register(cell.nib,
             forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
             withReuseIdentifier: "headerView")
  }
  
  func dequeueHeader(indexPath: IndexPath) -> UICollectionReusableView {
    return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                            withReuseIdentifier: "headerView",
                                            for: indexPath)
  }
  
  func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
      fatalError("Failed to dequeue a cell with identifier \(cellType.identifier) matching type \(cellType.self).")
    }
    return cell
  }

}

extension UICollectionViewCell: Reusable {
  open class var nib: UINib {
    return UINib(nibName: self.nibName, bundle: nil)
  }
}
