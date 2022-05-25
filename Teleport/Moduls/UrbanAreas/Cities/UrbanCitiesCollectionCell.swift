//
//  UrbanCitiesCollectionCell.swift
//  Teleport
//
//  Created by Майя Калицева on 24.05.2022.
//

import RxSwift

final class UrbanCitiesCollectionCell: UICollectionViewCell {
    
    // MARK: Private Properties
    
    private let cityName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupCellUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Methods
    
    func configure(name: UrbanAreasCityResponse) {
        cityName.text = name.name
    }

    // MARK: Private Methods
    
    private func setupCellUI() {
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemBrown.withAlphaComponent(0.3).cgColor
        layer.borderWidth = 3
    }

    private func setupLayout() {
        addSubview(cityName)
        
        cityName.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
    
}

