//
//  DetailsUrbanAreaTableCellViewModel.swift
//  Teleport
//
//  Created by Майя Калицева on 24.05.2022.
//

import RxRelay
import RxSwift
import RxCocoa

final class DetailsUrbanAreaTableCellViewModel: TableViewCellModelProtocol {
    
    // MARK: Public Properties

    let bag = DisposeBag()
    let urbanResponse: UrbanAreasHrefResponse
  //  let scoresResponse: ScoresResponse
    
    // MARK: Init
    
    init(urbanResponse: UrbanAreasHrefResponse) {
        self.urbanResponse = urbanResponse
     //   self.scoresResponse = scoresResponse
    }
    
    // MARK: Public Methods

    func configure(_ cell: DetailsUrbanAreaTableView) {
        cell.configure(name: urbanResponse)
    }
}
