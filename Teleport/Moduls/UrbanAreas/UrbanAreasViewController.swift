//
//  UrbanAreasViewController.swift
//  Teleport
//
//  Created by Майя Калицева on 13.05.2022.
//

import RxSwift
import RxCocoa

final class UrbanAreasViewController: UIViewController {
    
    // MARK: Public Properies

    var bag = DisposeBag()
    lazy var onItemTap = tableView.rx.modelSelected(UrbanAreasTableCellViewModel.self).map { $0 }
    
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
                UrbanAreasTableCellViewModel.self)
        return tbv
    }()
    
    private let viewModel: UrbanAreasViewModel
    
    // MARK: - Init
    
    init(viewModel: UrbanAreasViewModel) {
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
        viewModel.getUrbansList()
    }

    // MARK: Private Methods
    
    private func configure() {
        urbansLabel.text = "Urbans"
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
        
        onItemTap
            .bind { [weak self] tap in
                let valueToRemove = "https://api.teleport.org/api/urban_areas"
                var value = tap.urbanResponse.href
                value = (value.components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
                if let range = value.range(of: valueToRemove) {
                    value.removeSubrange(range)
                }
                self?.viewModel.flow.accept(.onUrbanTap(href: value))
                print("test1 \(value)")
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
