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
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Methods
    
    func configure(name: ContinentCountryResponse) {
        continentCountryName.text = name.name
    }

    // MARK: Private Methods

    private func setupLayout() {
        addSubview(continentCountryName)
        
        continentCountryName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(-15)
        }
    }
    
}
