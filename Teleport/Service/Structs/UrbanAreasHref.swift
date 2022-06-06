//
//  UrbanAreasHref.swift
//  Teleport
//
//  Created by Майя Калицева on 20.05.2022.
//

import Foundation

struct UrbanAreasHrefRoot: Decodable, Equatable {
    let links: UrbanAreasHrefResponse
    
    enum CodingKeys: String, CodingKey {
        case links = "_links"
    }
}

struct UrbanAreasHrefResponse: Decodable, Equatable {
    let continent: String
    let fullName: String
    let mayor: String?
    let name: String
    let uaId: String
    
    enum CodingKeys: String, CodingKey {
        case continent = "continent"
        case fullName = "full_name"
        case mayor = "mayor"
        case name = "name"
        case uaId = "ua_id"
    }
}
