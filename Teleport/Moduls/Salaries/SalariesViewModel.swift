//
//  SalariesViewModel.swift
//  Teleport
//
//  Created by Майя Калицева on 14.05.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class SalariesViewModel {

    // MARK: Public Properties
    
    private(set) var dataItems = PublishRelay<[AnyTableViewCellModelProtocol]>()
    let id: String
    let bag = DisposeBag()
    
    // MARK: Private Properties
    
    private let service: Service
    
    // MARK: - Initializers
    
    init(service: Service, id: String) {
        self.service = service
        self.id = id
        self.getContinentsList(id: id)
    }
    
    // MARK: Public Methods
    
    func getContinentsList(id: String) {
        service
            .countriesSalaries(id: id)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let response):
                    let salaries = response.salaries.map { SalariesTableCellViewModel(salary: $0, service: self.service)}
                    self.dataItems.accept(salaries)
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: bag)
    }
}

