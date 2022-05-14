//
//  Service.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//

import Foundation
import Moya
import RxSwift

protocol ServiceProtocol {
    func allCountries() -> Single<CountryRoot>
    func allContinents() -> Single<ContinentRoot>
    func continentsCountries(id: String) -> Single<ContinentCountryRoot>
    func allUrbanAreas() -> Single<UrbanAreasRoot>
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
    
    func allContinents() -> Single<ContinentRoot> {
        provider.rx.request(.allContinents)
            .map(ContinentRoot.self)
    }
    
    func continentsCountries(id: String) -> Single<ContinentCountryRoot> {
        provider.rx.request(.continentsCountries(id))
            .map(ContinentCountryRoot.self)
    }
    
    func allUrbanAreas() -> Single<UrbanAreasRoot> {
        provider.rx.request(.allUrbanAreas)
            .map(UrbanAreasRoot.self)
    }
}
