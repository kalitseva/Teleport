//
//  CountriesViewController.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CountriesViewController: UIViewController {
    
    // MARK: Public Properies
    
    let bag = DisposeBag()
    
    // MARK: Private Properies
    
    private let countriesLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.systemBlue.withAlphaComponent(0.6)
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let countriesTableView: UITableView = {
        let tbv = UITableView()
        tbv.backgroundColor = UIColor.systemBrown.withAlphaComponent(0.1)
        tbv.separatorStyle = .singleLine
        tbv.tableFooterView = UIView()
        tbv.rowHeight = UITableView.automaticDimension
        tbv.delaysContentTouches = false
        tbv.keyboardDismissMode = .onDrag
        tbv.registerCells(
            withModels:
                CountryTableCellViewModel.self)
        return tbv
    }()
    
    private let viewModel: CountriesViewModel

    // MARK: - Init

    init(viewModel: CountriesViewModel) {
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
        viewModel.getCountriesList()
    }
    
    // MARK: Public Methods
    
    func configure() {
        countriesLabel.text = "Countries"
    }
    
    // MARK: Private Methods
    
    private func bindVM() {
        viewModel
            .dataItems
            .bind(to: countriesTableView.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.dequeueReusableCell(withModel: data, for: indexPath)
                data.configureAny(cell)
                return cell
            }
            .disposed(by: bag)
    }
    
    private func setupLayout() {
        view.addSubview(countriesLabel)
        view.addSubview(countriesTableView)
        
        countriesLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(countriesTableView.snp.top).inset(-15)
        }
        
        countriesTableView.snp.makeConstraints { make in
            make.top.equalTo(countriesLabel.snp.bottom).inset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(-15)
        }
    }
}
