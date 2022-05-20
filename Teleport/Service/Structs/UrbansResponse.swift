//
//  TimezonesResponse.swift
//  Teleport
//
//  Created by Майя Калицева on 13.05.2022.
//

import Foundation

struct UrbanAreasRoot: Decodable, Equatable {
    let links: UrbanAreasMiddle
    
    enum CodingKeys: String, CodingKey {
        case links = "_links"
    }
}

struct UrbanAreasMiddle: Decodable, Equatable {
    let uaItems: [UrbanAreasResponse]
    
    enum CodingKeys: String, CodingKey {
        case uaItems = "ua:item"
    }
}

struct UrbanAreasResponse: Decodable, Equatable {
    let href: String
    let name: String
}
    

