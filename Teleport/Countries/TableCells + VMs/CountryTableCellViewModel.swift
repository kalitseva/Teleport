//
//  CountryTableCellViewModel.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//

import RxCocoa
import RxSwift

final class CountryTableCellViewModel: TableViewCellModelProtocol {
    
    // MARK: Private Properties
    
    private var countryName: CountriesResponse
    
    // MARK: Public methods
    
    init(countryInfo: CountriesResponse) {
        countryName = countryInfo
    }
    
    func configure(_ cell: CountryTableCell) {
        cell.setCountryInfo(
            countryInfo: countryName.name)
    }
}
