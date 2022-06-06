//
//  CitiesTableCellViewModel.swift
//  Teleport
//
//  Created by Майя Калицева on 30.04.2022.
//

final class ContinentsTableCellViewModel: TableViewCellModelProtocol{
    
    // MARK: Private Properties
    
    private var continentName: ContinentsResponse
    
    // MARK: Public methods
    
    init(continentInfo: ContinentsResponse) {
        continentName = continentInfo
    }
    
    func configure(_ cell: ContinentsTableCell) {
        cell.setContinentInfo(continentInfo: continentName.name)
    }
}
