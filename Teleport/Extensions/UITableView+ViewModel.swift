//
//  UITableView+ViewMovel.swift
//  
//
//
//

import UIKit

extension UITableView {

    func registerCells(withModels models: AnyTableViewCellModelProtocol.Type...) {
        models.forEach {
            register(cellType: $0.cellClass)
        }
    }

    func dequeueReusableCell(withModel model: AnyTableViewCellModelProtocol, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: type(of: model).reuseIdentifier, for: indexPath)
    }

    func dequeueReusableCell(withModel model: AnyTableCellItem, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withModel: model.modelInstance, for: indexPath)
    }

    func dequeueReusableCell(withModelType modelType: AnyTableViewCellModelProtocol.Type, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: modelType.reuseIdentifier, for: indexPath)
    }
}
