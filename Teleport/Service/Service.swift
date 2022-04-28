//
//  Service.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//

import Foundation
import Moya
import RxSwift

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

protocol ServiceProtocol {
    func allCountries() -> Single<CountryRoot>
}

final class Service: ServiceProtocol {
    
    // MARK: - Private Properties
    
    
    private lazy var plugins: [NetworkLoggerPlugin] = {
        return [NetworkLoggerPlugin(configuration: .init( logOptions: .verbose))]
    }()
    
    private lazy var provider = MoyaProvider<Target>(plugins: plugins)
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: - Public Methods
    
    func allCountries() -> Single<CountryRoot> {
        provider.rx.request(.allCountries)
            .map(CountryRoot.self)
    }
}