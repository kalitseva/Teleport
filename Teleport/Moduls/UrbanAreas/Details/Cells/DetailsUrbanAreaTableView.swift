//
//  DetailsUrbanAreaTableView.swift
//  Teleport
//
//  Created by Майя Калицева on 24.05.2022.
//

import RxSwift
import UIKit

final class DetailsUrbanAreaTableView: UITableViewCell {
    
    // MARK: Private Properties
    
    private let continent: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let fullName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let mayor: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Methods
    
    func configure(name: UrbanAreasHrefResponse) {
        continent.text = "Continent: \(name.continent)"
        fullName.text = "Full name: \(name.fullName)"
        mayor.text = "Mayor: \(name.mayor)"
    }

    // MARK: Private Methods
    
    private func cellStyle() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    private func setupLayout() {
        addSubview(continent)
        addSubview(fullName)
        addSubview(mayor)

        continent.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(15)
            make.bottom.equalTo(fullName.snp.top).inset(-12)
        }
        
        fullName.snp.makeConstraints { make in
            make.top.equalTo(continent.snp.bottom).inset(12)
            make.leading.equalToSuperview().inset(15)
            make.bottom.equalTo(mayor.snp.top).inset(-12)
        }
        
        mayor.snp.makeConstraints { make in
            make.top.equalTo(fullName.snp.bottom).inset(12)
            make.leading.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(12)
        }
    }
}


