//
//  TabItem.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//


import UIKit

enum TabItem: String, CaseIterable {
    case salaries = "salaries"
    case picturesSearch = "picturesSearch"
    case urbans = "urbans"

    var icon: UIImage? {
        switch self {
        case .salaries:
            return UIImage(systemName: "dollarsign.circle")
        case .picturesSearch:
            return UIImage(systemName: "magnifyingglass.circle")
        case .urbans:
            return UIImage(systemName: "car.circle")
        }
    }

    var iconForActive: UIImage? {
        switch self {
        case .salaries:
            return UIImage(systemName: "dollarsign.circle.fill")
        case .picturesSearch:
            return UIImage(systemName: "magnifyingglass.circle.fill")
        case .urbans:
            return UIImage(systemName: "car.circle.fill")
        }
    }
}

