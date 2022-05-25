//
//  UIProgressView + UILabel.swift
//  Teleport
//
//  Created by Майя Калицева on 25.05.2022.
//

import UIKit

final class CustomProgressLabelView: UIView {
    
    // MARK: Private Properties
    
    private let progressView = UIProgressView(progressViewStyle: .default)
    
    private let cityRanking: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.darkGray
        return lbl
    }()
    
    private let category: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.darkGray
        return lbl
    }()
    
    private let scoreToTen: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.darkGray
        return lbl
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 15
        return sv
    }()
    
    let progressViews: [UIProgressView] = (0 ..< 4).map { _ in
        let view = UIProgressView()
        return view
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    
    func configure(response: ScoresResponse) {
        progressView.tintColor = UIColor(named: response.color)
        category.text = response.name
        scoreToTen.text = String(response.score)
        cityRanking.text = String(response.teleportScore)
    }

    // MARK: Private Methods
    
    private func setupLayout() {
        addSubview(stackView)
        for progressView in progressViews {
            stackView.addArrangedSubview(progressView)
            stackView.addArrangedSubview(cityRanking)
            stackView.addArrangedSubview(scoreToTen)
            stackView.addArrangedSubview(category)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        cityRanking.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.top)
            make.leading.equalTo(progressView.snp.trailing).inset(15)
            make.bottom.equalToSuperview()
        }
    }
}
