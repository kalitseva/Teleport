//
//  DetailsUrbanAreaVM.swift
//  Teleport
//
//  Created by Майя Калицева on 24.05.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailsUrbanAreaVM {

    // MARK: Public Properties

    let bag = DisposeBag()
    
    // MARK: Private Properties
    
    private let service: Service

    // MARK: - Init
    
    init(service: Service) {
        self.service = service
    }
    
    // MARK: Public Methods
    
    func getUrbansDetailsList(id: String, vc: DetailUrbanAreaVC) {
        service.urbanAreasHref(id: id)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let response):
                    let uaID = response.uaId
                    vc.configureDetails(details: response)
                    self.getScores(uaID: uaID, vc: vc)
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: bag)
    }
    
    func getScores(uaID: String, vc: DetailUrbanAreaVC) {
        service.score(id: uaID)
            .subscribe { [weak self] event in
                switch event {
                case .success(let response):
                    vc.configureScores(scores: response)
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: bag)
    }
}



