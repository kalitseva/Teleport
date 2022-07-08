//
//  UICollectionView+ViewModel.swift
//  
//
//
//

import UIKit

extension UICollectionView {

    func registerCells(withModels models: AnyCollectionViewCellModelProtocol.Type...) {
        models.forEach {
                register($0.cellClass, forCellWithReuseIdentifier: $0.reuseIdentifier)
        }
    }

    func dequeueReusableCell(withModel model: AnyCollectionViewCellModelProtocol, for indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: type(of: model).reuseIdentifier, for: indexPath)
    }

    func dequeueReusableCell(withModel model: AnyCollectionCellItem, for indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueReusableCell(withModel: model.modelInstance, for: indexPath)
    }

    func dequeueReusableCell(withModelType modelType: AnyCollectionViewCellModelProtocol.Type, for indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: modelType.reuseIdentifier, for: indexPath)
    }
}
