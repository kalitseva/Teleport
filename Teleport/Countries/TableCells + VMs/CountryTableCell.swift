//
//  CountryTableCell.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//

import UIKit

final class CountryTableCell: UITableViewCell {
    
    // MARK: Private Properies
    
    private let countryName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        cellStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Methods
    
    func setCountryInfo(countryInfo: String) {
        countryName.text = countryInfo
    }
    
    // MARK: Private Methods
    
    private func cellStyle() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupLayout() {
        addSubview(countryName)
        
        countryName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(-30)
        }
    }
}