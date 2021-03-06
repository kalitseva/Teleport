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
    func allContinents() -> Single<ContinentRoot>
    func continentsCountries(id: String) -> Single<ContinentCountryRoot>
    func countriesSalaries(id: String) -> Single<SalaryRoot>
    func allUrbanAreas() -> Single<UrbanAreasRoot>
    func urbanAreasHref(id: String) -> Single<UrbanAreasHrefResponse>
    func score(id: String) -> Single<ScoresRoot>
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

    func allContinents() -> Single<ContinentRoot> {
        provider.rx.request(.allContinents)
            .map(ContinentRoot.self)
    }
    
    func continentsCountries(id: String) -> Single<ContinentCountryRoot> {
        provider.rx.request(.continentsCountries(id))
            .map(ContinentCountryRoot.self)
    }
    
    func countriesSalaries(id: String) -> Single<SalaryRoot> {
        provider.rx.request(.countriesSalaries(id))
            .map(SalaryRoot.self)
    }
    
    func allUrbanAreas() -> Single<UrbanAreasRoot> {
        provider.rx.request(.allUrbanAreas)
            .map(UrbanAreasRoot.self)
    }
    
    func urbanAreasHref(id: String) -> Single<UrbanAreasHrefResponse> {
        provider.rx.request(.urbanAreasHref(id))
            .map(UrbanAreasHrefResponse.self)
    }
    
    func score(id: String) -> Single<ScoresRoot> {
        provider.rx.request(.score(id))
            .map(ScoresRoot.self)
    }
}
