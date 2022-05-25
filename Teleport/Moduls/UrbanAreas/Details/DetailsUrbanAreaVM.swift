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
    
    enum Flow {
        case uiID(id: String)
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
    /*
    func getUrbansScoresList(id: String, uaID: String) {
        Single.zip(service.urbanAreasHref(id: id), service.score(id: uaID))
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success((let response1, let response2)):
                    var items: [AnyTableViewCellModelProtocol] = []
                    let urbans = DetailsUrbanAreaTableCellViewModel(urbanResponse: response1, scoresResponse: response2)
                    self.flow.accept(.uiID(id: response1.uaId))
                    items.append(urbans)
                    self.dataItems.accept(items)
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: bag)
    }
     */
    
    func getUrbansScoresList(id: String) {
       service
            .urbanAreasHref(id: id)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let response):
                    var items: [AnyTableViewCellModelProtocol] = []
                    let urbans = DetailsUrbanAreaTableCellViewModel(urbanResponse: response)
                    self.flow.accept(.uiID(id: response.uaId))
                    items.append(urbans)
                    self.dataItems.accept(items)
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: bag)
    }
}



