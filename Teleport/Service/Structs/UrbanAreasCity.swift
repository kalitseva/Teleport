//
//  UrbanAreasCity.swift
//  Teleport
//
//  Created by Майя Калицева on 24.05.2022.
//

import Foundation

struct UrbanAreasCityRoot: Decodable, Equatable {
    let links: UrbanAreasCityMiddle
    
    enum CodingKeys: String, CodingKey {
        case links = "_links"
    }
}

struct UrbanAreasCityMiddle: Decodable, Equatable {
    let cityItems: [UrbanAreasCityResponse]
    
    enum CodingKeys: String, CodingKey {
        case cityItems = "city:items"
    }
}

struct UrbanAreasCityResponse: Decodable, Equatable {
    let href: String
    let name: String
}

