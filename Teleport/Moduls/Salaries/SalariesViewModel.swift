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
    
    enum Flow {
        case onEmptyCountry
    }
    
    // MARK: Public Properties
    
    private(set) var dataItems = PublishRelay<[AnyTableViewCellModelProtocol]>()
    let id: String
    let bag = DisposeBag()
    let flow = PublishRelay<Flow>()
    
    // MARK: Private Properties
    
    private let service: Service
    
    // MARK: - Init
    
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
                    if response.salaries.isEmpty {
                        self.flow.accept(.onEmptyCountry)
                    } else {
                        let salaries = response.salaries.map { SalariesTableCellViewModel(salary: $0, service: self.service)}
                        self.dataItems.accept(salaries)
                    }
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: bag)
    }
}

