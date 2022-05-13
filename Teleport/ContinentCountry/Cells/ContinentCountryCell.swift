//
//  ContinentCountryCell.swift
//  Teleport
//
//  Created by Майя Калицева on 07.05.2022.
//

import RxSwift

final class ContinentCountryCell: UICollectionViewCell {
    
    // MARK: Private Properties
    
    private let continentCountryName: UILabel = {
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
    
    func configure(name: ContinentCountryResponse) {
        continentCountryName.text = name.name
    }

    // MARK: Private Methods
    
    private func setupCellUI() {
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemBrown.withAlphaComponent(0.3).cgColor
        layer.borderWidth = 3
    }

    private func setupLayout() {
        addSubview(continentCountryName)
        
        continentCountryName.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
    
}
