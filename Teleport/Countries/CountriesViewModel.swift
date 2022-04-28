//
//  CountriesViewModel.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftUI

final class CountriesViewModel {
    
    private(set) var dataItems = PublishRelay<[AnyTableViewCellModelProtocol]>()
    let bag = DisposeBag()
    
    private let service: Service
    
    // MARK: - Initializers
    
    init(service: Service) {
        self.service = service
    }
    
    func getCountriesList() {
        service
            .allCountries()
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let response):
                    var items: [AnyTableViewCellModelProtocol] = []
                    let data = response.links.countryItems.map { CountryTableCellViewModel(countryInfo: $0 )}
                    self.dataItems.accept(data)
                    
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: bag)
    }
}
