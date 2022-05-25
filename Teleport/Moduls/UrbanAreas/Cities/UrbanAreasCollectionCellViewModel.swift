//
//  UrbanAreasCollectionCellViewModel.swift
//  Teleport
//
//  Created by Майя Калицева on 24.05.2022.
//

import RxSwift

final class UrbanAreasCollectionCellViewModel: CollectionViewCellModelProtocol {
    
    // MARK: - Public Properties

     let urbanCity: UrbanAreasCityResponse

     // MARK: - Initializers

     init(urbanCity: UrbanAreasCityResponse) {
         self.urbanCity = urbanCity
     }

     // MARK: - Public Methods

     func configure(_ cell: UrbanCitiesCollectionCell) {
         cell.configure(name: urbanCity)
     }
}
