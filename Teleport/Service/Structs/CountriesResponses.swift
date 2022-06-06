//
//  CountriesResponses.swift
//  Teleport
//
//  Created by Майя Калицева on 28.04.2022.
//

struct CountryRoot: Decodable, Equatable {
    let links: CountryMiddle
    
    enum CodingKeys: String, CodingKey {
        case links = "_links"
    }
}

struct CountryMiddle: Decodable, Equatable {
    let countryItems: [CountriesResponse]
    
    enum CodingKeys: String, CodingKey {
        case countryItems = "country:items"
    }
}

struct CountriesResponse: Decodable, Equatable {
    let href: String
    let name: String
}
