//
//  LabelProgressView.swift
//  Teleport
//
//  Created by Майя Калицева on 30.05.2022.
//

import UIKit

final class LabelProgressTableCell: UITableViewCell {
    
    // MARK: Private Properies
    
    private let progressLabelScore: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.black
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let category: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textColor = UIColor.black
        lbl.backgroundColor = UIColor.systemPink.withAlphaComponent(0.6)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let progressView: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .default)
        pv.trackTintColor = UIColor.gray
        return pv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configure(model: [ScoresMiddle]) {
        model.forEach { value in
            progressLabelScore.text = String(value.score)
            category.text = value.name
            progressView.tintColor = hexStringToUIColor(hex: value.color)
            progressView.setProgress(Float(value.score) / 10, animated: true)
        }
    }
       

    // MARK: - Private Methods
    
    private func setupLayout() {
        addSubview(category)
        addSubview(progressView)
        addSubview(progressLabelScore)
        
        category.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(progressView.snp.top).inset(-15)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(category.snp.bottom).inset(15)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(progressLabelScore.snp.top).inset(-15)
        }
        
        progressLabelScore.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).inset(15)
            make.centerX.equalTo(progressView.snp.centerX)
            make.bottom.equalToSuperview().inset(15)
        }
    }
}
