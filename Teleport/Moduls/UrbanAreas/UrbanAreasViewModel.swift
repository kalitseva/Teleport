//
//  UrbanAreasViewModel.swift
//  Teleport
//
//  Created by Майя Калицева on 13.05.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class UrbanAreasViewModel {
    
    enum Flow {
        case onUrbanTap(href: String)
    }
    
    // MARK: Public Properties
    
    private(set) var dataItems = PublishRelay<[AnyTableViewCellModelProtocol]>()
    let bag = DisposeBag()
    let flow = PublishRelay<Flow>()
    
    // MARK: Private Properties
    
    private let service: Service
    
    // MARK: - Init
    
    init(service: Service) {
        self.service = service
    }
    
    // MARK: Public Methods
    
    func getUrbansList() {
        service
            .allUrbanAreas()
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let response):
                    let urbans = response.links.uaItems.map { UrbanAreasTableCellViewModel(urbanResponse: $0)}
                        self.dataItems.accept(urbans)
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: bag)
    }
}


