//
//  SalariesTableCellViewModel.swift
//  Teleport
//
//  Created by Майя Калицева on 14.05.2022.
//

import RxRelay
import RxSwift
import RxCocoa

final class SalariesTableCellViewModel: TableViewCellModelProtocol {

    // MARK: Private Properties
    
    private let salariesResponse: SalaryMiddle
    private let service: Service

    // MARK: Init
    
    init(salary: SalaryMiddle, service: Service) {
        self.salariesResponse = salary
        self.service = service
    }

    // MARK: Public Methods

    func configure(_ cell: SalariesTableCell) {
        cell.setJobInfo(jobNames: salariesResponse)
     }
}

