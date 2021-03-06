//
//  CitiesViewController.swift
//  Teleport
//
//  Created by Майя Калицева on 30.04.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ContinentsViewController: UIViewController {
    
    // MARK: Public Properies
    
    lazy var onContinentTap = continentsTableView.rx.modelSelected(ContinentsTableCellViewModel.self).map { $0.continentName } // отслеживание выделения ячейки коллекции
    let bag = DisposeBag()
    
    // MARK: Private Properies
    
    private let salariesLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.systemBlue.withAlphaComponent(0.7)
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let chooseContinentLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.systemBlue.withAlphaComponent(0.8)
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        lbl.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.2)
        return lbl
    }()
    
    private let continentsTableView: UITableView = {
        let tbv = UITableView()
        tbv.backgroundColor = UIColor.systemBrown.withAlphaComponent(0.1)
        tbv.separatorStyle = .singleLine
        tbv.tableFooterView = UIView()
        tbv.rowHeight = UITableView.automaticDimension
        tbv.keyboardDismissMode = .onDrag
        tbv.registerCells(
            withModels:
                ContinentsTableCellViewModel.self)
        return tbv
    }()
    
    private let viewModel: ContinentsViewModel
    
    // MARK: - Init
    
    init(viewModel: ContinentsViewModel) {
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
        bindVM()
        configure()
        setupLayout()
        viewModel.getContinentsList()
    }
    
    // MARK: Public Methods
    
    func configure() {
        salariesLabel.text = "Want to know more about salaries?"
        chooseContinentLabel.text = "Choose continent, please:"
    }
    
    // MARK: Private Methods
    
    private func bindVM() {
        viewModel
            .dataItems
            .bind(to: continentsTableView.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.dequeueReusableCell(withModel: data, for: indexPath)
                data.configureAny(cell)
                return cell
            }
            .disposed(by: bag)
        
        onContinentTap
            .bind { [weak self] tap in
                let valueToRemove = "https://api.teleport.org/api/continents"
                var value = tap.href
                value = (value.components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
                if let range = value.range(of: valueToRemove) {
                    value.removeSubrange(range)
                }
                self?.viewModel.flow.accept(.onContinentTap(continent: value))
            }
            .disposed(by: bag)
    }
    
    private func setupLayout() {
        view.addSubview(salariesLabel)
        view.addSubview(chooseContinentLabel)
        view.addSubview(continentsTableView)
        
        salariesLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(chooseContinentLabel.snp.top).inset(-15)
        }
        
        chooseContinentLabel.snp.makeConstraints { make in
            make.top.equalTo(salariesLabel.snp.bottom).inset(15)
            make.leading.equalToSuperview().inset(8)
            make.bottom.equalTo(continentsTableView.snp.top).inset(-15)
        }
        
        continentsTableView.snp.makeConstraints { make in
            make.top.equalTo(chooseContinentLabel.snp.bottom).inset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(-15)
        }
    }
}

