//
//  DetailUrbanAreaVC.swift
//  Teleport
//
//  Created by Майя Калицева on 24.05.2022.
//

import RxSwift
import RxCocoa
import UIKit

final class DetailUrbanAreaVC: UIViewController {
    
    // MARK: Public Properies
    
    var bag = DisposeBag()
    
    // MARK: Private Properies
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private let continentName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black.withAlphaComponent(0.7)
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let fullName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black.withAlphaComponent(0.7)
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let mayor: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black.withAlphaComponent(0.7)
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let summary: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black.withAlphaComponent(0.7)
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let viewModel: DetailsUrbanAreaVM
    
    // MARK: - Init
    
    init(viewModel: DetailsUrbanAreaVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    // MARK: Public Methods

    func configureDetails(details: UrbanAreasHrefResponse) {
        configureAttributedString(color: UIColor.black, color2: UIColor.systemGray, label: continentName, font: UIFont.boldSystemFont(ofSize: 17), text: "Continent: ", text2: details.continent)
        
        configureAttributedString(color: UIColor.black, color2: UIColor.systemGray, label: fullName, font: UIFont.boldSystemFont(ofSize: 17), text: "Full name: ", text2: details.fullName)
        
        guard let mayorName = details.mayor else { return  configureAttributedString(color: UIColor.black, color2: UIColor.systemGray, label: mayor, font: UIFont.boldSystemFont(ofSize: 17), text: "Mayor: ", text2: "No info")
        }
        
        configureAttributedString(color: UIColor.black, color2: UIColor.systemGray, label: mayor, font: UIFont.boldSystemFont(ofSize: 17), text: "Mayor: ", text2: mayorName)
    }
    
    func configureScores(scores: ScoresRoot) {
        let cleanValue = scores.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        configureAttributedString(color: UIColor.black, color2: UIColor.systemGray, label: summary, font: UIFont.boldSystemFont(ofSize: 17), text: "Summary: ", text2: cleanValue)
    }
    
    // MARK: Private Methods
    
    private func configureAttributedString(color: UIColor, color2: UIColor, label: UILabel, font: UIFont, text: String, text2: String) {
        let attributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
         NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let attributedString = NSMutableAttributedString(
            string: text, attributes: attributes)
        let anotherAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let anotherString = NSMutableAttributedString(
            string: text2, attributes: anotherAttributes)
        attributedString.append(anotherString)
        label.attributedText = attributedString
    }
    
    private func setupLayout() {
        let safeG = view.safeAreaLayoutGuide
        let contentG = scrollView.contentLayoutGuide

        view.addSubview(scrollView)
        scrollView.addSubview(continentName)
        scrollView.addSubview(fullName)
        scrollView.addSubview(mayor)
        scrollView.addSubview(summary)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeG.snp.top).inset(8)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(safeG.snp.bottom).inset(-8)
        }
        
        continentName.snp.makeConstraints { make in
            make.top.equalTo(contentG.snp.top).inset(15)
            make.leading.equalTo(view.snp.leading).inset(10)
            make.trailing.equalTo(view.snp.trailing).inset(10)
            make.bottom.equalTo(fullName.snp.top).inset(-15)
        }
        
        fullName.snp.makeConstraints { make in
            make.top.equalTo(continentName.snp.bottom).inset(15)
            make.leading.equalTo(view.snp.leading).inset(10)
            make.trailing.equalTo(view.snp.trailing).inset(10)
            make.bottom.equalTo(mayor.snp.top).inset(-15)
        }
        
        mayor.snp.makeConstraints { make in
            make.top.equalTo(fullName.snp.bottom).inset(15)
            make.leading.equalTo(view.snp.leading).inset(10)
            make.trailing.equalTo(view.snp.trailing).inset(10)
            make.bottom.equalTo(summary.snp.top).inset(-15)
        }
        
        summary.snp.makeConstraints { make in
            make.top.equalTo(mayor.snp.bottom).inset(5)
            make.leading.equalTo(view.snp.leading).inset(10)
            make.trailing.equalTo(view.snp.trailing).inset(10)
            make.bottom.equalToSuperview()
        }
        
    }
}

