//
//  UrbanAreasTableCell.swift
//  Teleport
//
//  Created by Майя Калицева on 13.05.2022.
//

import RxSwift

final class UrbanAreasTableCell: UITableViewCell {
    
    // MARK: Private Properties
    
    private let urbanAreaLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
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
    
    func configure(name: String) {
        urbanAreaLabel.text = name
    }

    // MARK: Private Methods
    
    private func cellStyle() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    private func setupLayout() {
        addSubview(urbanAreaLabel)
        urbanAreaLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(12)
        }
    }
}

