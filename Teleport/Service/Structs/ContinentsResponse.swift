//
//  ContinentsResponse.swift
//  Teleport
//
//  Created by Майя Калицева on 30.04.2022.
//

struct ContinentRoot: Decodable, Equatable {
    let links: ContinentMiddle
    
    enum CodingKeys: String, CodingKey {
        case links = "_links"
    }
}

struct ContinentMiddle: Decodable, Equatable {
    let continentItems: [ContinentsResponse]
    
    enum CodingKeys: String, CodingKey {
        case continentItems = "continent:items"
    }
}

struct ContinentsResponse: Decodable, Equatable {
    let href: String
    let name: String
}
