//
//  ContinentCountryViewController.swift
//  Teleport
//
//  Created by Майя Калицева on 07.05.2022.
//

import RxSwift
import RxRelay

final class ContinentCountryViewController: UIViewController {
    
    // MARK: Public Properties
    
    private(set) var bag = DisposeBag()
    
    // MARK: Private Properties
    
    private let salariesLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.systemBlue.withAlphaComponent(0.7)
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let chooseCountryLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.systemBlue.withAlphaComponent(0.8)
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        lbl.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.2)
        return lbl
    }()
    
    private let viewModel: ContinentCountryViewModel
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 50)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        let cvc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cvc.backgroundColor = .white
        cvc.showsHorizontalScrollIndicator = false
        cvc.registerCells(withModels: ContinentCountryCellViewModel.self)
        return cvc
    }()
    
    // MARK: - Init

    init(viewModel: ContinentCountryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setupLayout()
        configure()
    }

    // MARK: - Public Methods
    
    func bindUI() {
        viewModel
            .collectionDataItems
            .bind(to: collectionView.rx.items) { collectionView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withModel: data, for: indexPath)
                data.configureAny(cell)
                return cell
            }
            .disposed(by: bag)
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        salariesLabel.text = "Want to know more about salaries?"
        chooseCountryLabel.text = "Choose country, please:"
    }

    private func setupLayout() {
        view.backgroundColor = UIColor.white
        view.addSubview(salariesLabel)
        view.addSubview(chooseCountryLabel)
        view.addSubview(collectionView)
        
        salariesLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(chooseCountryLabel.snp.top).inset(-15)
        }
        
        chooseCountryLabel.snp.makeConstraints { make in
            make.top.equalTo(salariesLabel.snp.bottom).inset(15)
            make.leading.equalToSuperview().inset(8)
            make.bottom.equalTo(collectionView.snp.top).inset(-15)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(chooseCountryLabel.snp.bottom).inset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
    }
}
