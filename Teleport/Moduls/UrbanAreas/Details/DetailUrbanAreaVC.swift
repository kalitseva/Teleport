//
//  DetailUrbanAreaVC.swift
//  Teleport
//
//  Created by Майя Калицева on 24.05.2022.
//

import RxSwift
import RxCocoa

final class DetailUrbanAreaVC: UIViewController {
    
    // MARK: Public Properies

    var bag = DisposeBag()
    
    // MARK: Private Properies
    
    private let urbansLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.systemBlue.withAlphaComponent(0.7)
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let tableView: UITableView = {
        let tbv = UITableView()
        tbv.backgroundColor = UIColor.systemBrown.withAlphaComponent(0.1)
        tbv.separatorStyle = .singleLine
        tbv.tableFooterView = UIView()
        tbv.rowHeight = UITableView.automaticDimension
        tbv.keyboardDismissMode = .onDrag
        tbv.registerCells(
            withModels:
                DetailsUrbanAreaTableCellViewModel.self)
        return tbv
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
        bindVM()
        setupLayout()
        configure()
    }

    // MARK: Private Methods
    
    private func configure() {
        urbansLabel.text = "Details"
    }
    
    private func bindVM() {
        viewModel
            .dataItems
            .bind(to: tableView.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.dequeueReusableCell(withModel: data, for: indexPath)
                data.configureAny(cell)
                return cell
            }
            .disposed(by: bag)
    }
    
    private func setupLayout() {
        view.addSubview(urbansLabel)
        view.addSubview(tableView)

        urbansLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top).inset(-15)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(urbansLabel.snp.bottom).inset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(15)
        }
    }
}

