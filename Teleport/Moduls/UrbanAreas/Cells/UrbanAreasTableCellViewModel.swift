//
//  UrbanAreasTableCellViewModel.swift
//  Teleport
//
//  Created by Майя Калицева on 13.05.2022.
//

import RxRelay
import RxSwift
import RxCocoa

final class UrbanAreasTableCellViewModel: TableViewCellModelProtocol {
    
    // MARK: Public Properties

    let bag = DisposeBag()
    let urbanResponse: UrbanAreasResponse
    
    // MARK: Init
    
    init(urbanResponse: UrbanAreasResponse) {
        self.urbanResponse = urbanResponse
    }
    
    // MARK: Public Methods

    func configure(_ cell: UrbanAreasTableCell) {
        cell.configure(name: urbanResponse.name)
    }
}
