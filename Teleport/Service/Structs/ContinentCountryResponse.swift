//
//  ContinentCountryResponse.swift
//  Teleport
//
//  Created by Майя Калицева on 07.05.2022.
//

import Foundation

struct ContinentCountryRoot: Decodable, Equatable {
    let links: ContinentCountryMiddle
    
    enum CodingKeys: String, CodingKey {
        case links = "_links"
    }
}

struct ContinentCountryMiddle: Decodable, Equatable {
    let countryItems: [ContinentCountryResponse]
    
    enum CodingKeys: String, CodingKey {
        case countryItems = "country:items"
    }
}

struct ContinentCountryResponse: Decodable, Equatable {
    let href: String
    let name: String
}
    

