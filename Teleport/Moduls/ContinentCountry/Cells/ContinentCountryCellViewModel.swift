//
//  ContinentCountryCellViewModel.swift
//  Teleport
//
//  Created by Майя Калицева on 07.05.2022.
//

import RxSwift

final class ContinentCountryCellViewModel: CollectionViewCellModelProtocol {
    
    // MARK: - Public Properties

     let continentCountry: ContinentCountryResponse

     // MARK: - Initializers

     init(continentCountry: ContinentCountryResponse) {
         self.continentCountry = continentCountry
     }

     // MARK: - Public Methods

     func configure(_ cell: ContinentCountryCell) {
         cell.configure(name: continentCountry)
     }
}
