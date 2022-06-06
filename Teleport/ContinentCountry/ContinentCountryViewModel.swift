//
//  ContinentCountryViewModel.swift
//  Teleport
//
//  Created by Майя Калицева on 07.05.2022.
//

import RxSwift
import RxCocoa

final class ContinentCountryViewModel {
    
    enum Flow {
        case showCountriesList(continent: String)
    }
    
    // MARK: - Public Properties
    
    let bag = DisposeBag()
    let service: Service
    let id: String
    let flow = PublishRelay<Flow>()
    
    // MARK: - Private Properties
    
    let collectionDataItems = PublishRelay<[ContinentCountryCellViewModel]>()
    
    // MARK: - Initializers
    
    init(service: Service, id: String) {
        self.service = service
        self.id = id
        self.continentsCountries(id: id)
    }
    
    // MARK: - Public Properties
    
    func setupTableData(data: [ContinentCountryResponse]?) {
        var collectionItems = [ContinentCountryCellViewModel]()
        if let data = data {
            collectionItems  = data.map { value in ContinentCountryCellViewModel(continentCountry: value) }
            collectionDataItems.accept(collectionItems)
        }
    }
    
    
    func continentsCountries(id: String) {
        service
            .continentsCountries(id: id)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let response):
                    self.setupTableData(data: response.links.countryItems)
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: bag)
    }
}
