//
//  CitiesViewModel.swift
//  Teleport
//
//  Created by Майя Калицева on 30.04.2022.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftUI

final class ContinentsViewModel {
    
    // MARK: Public Properties
    
    private(set) var dataItems = PublishRelay<[AnyTableViewCellModelProtocol]>()
    let bag = DisposeBag()
    
    // MARK: Private Properties
    
    private let service: Service
    
    // MARK: - Initializers
    
    init(service: Service) {
        self.service = service
    }
    
    // MARK: Public Methods
    
    func getContinentsList() {
        service
            .allContinents()
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let response):
                    // Parse into cell ViewModel data from response
                    let data = response.links.continentItems.map { ContinentsTableCellViewModel(continentInfo: $0 )}
                    // add to dataItems of ViewModel data from response to reload cells with proper information
                    self.dataItems.accept(data)
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: bag)
    }
}
