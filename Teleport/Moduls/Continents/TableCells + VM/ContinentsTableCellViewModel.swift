//
//  CitiesTableCellViewModel.swift
//  Teleport
//
//  Created by Майя Калицева on 30.04.2022.
//

import RxRelay
import RxSwift
import RxCocoa

final class ContinentsTableCellViewModel: TableViewCellModelProtocol {

    // MARK: Public Properties

    let bag = DisposeBag()
    
    // MARK: Private Properties
    
    var continentName: ContinentsResponse
    
    // MARK: Public Methods
    
    init(continentInfo: ContinentsResponse) {
        continentName = continentInfo
    }
    
    func configure(_ cell: ContinentsTableCell) {
        cell.setContinentInfo(continentInfo: continentName.name)
     }
}
