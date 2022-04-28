//
//  TabItem.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//


import UIKit

enum TabItem: String, CaseIterable {
    case countries = "countries"
    case search = "search"
    case cities = "cities"
    case timezones = "timezones"

    var icon: UIImage? {
        switch self {
        case .countries:
            return UIImage(systemName: "globe.europe.africa")
        case .search:
            return UIImage(systemName: "magnifyingglass.circle")
        case .cities:
            return UIImage(systemName: "car.circle")
        case .timezones:
            return UIImage(systemName: "clock")
        }
    }

    var iconForActive: UIImage? {
        switch self {
        case .countries:
            return UIImage(systemName: "globe.europe.africa.fill")
        case .search:
            return UIImage(systemName: "magnifyingglass.circle.fill")
        case .cities:
            return UIImage(systemName: "car.circle.fill")
        case .timezones:
            return UIImage(systemName: "clock.fill")
        }
    }
}

