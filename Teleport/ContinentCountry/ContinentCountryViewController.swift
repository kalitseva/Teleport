//
//  ContinentCountryViewController.swift
//  Teleport
//
//  Created by Майя Калицева on 07.05.2022.
//

import RxSwift

final class ContinentCountryViewController: UIViewController {
    
    // MARK: Public Properties
    
    private(set) var bag = DisposeBag()
    
    // MARK: Private Properties
    
    private let viewModel: ContinentCountryViewModel

    private let continentCountryName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.systemBlue.withAlphaComponent(0.6)
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.numberOfLines = 0
        return lbl
    }()
    
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
        bind()
        configure()
        setupLayout()
        view.backgroundColor = UIColor.white
    }

    // MARK: - Public Method
    
    func bind() {
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
    
    func configure() {
        continentCountryName.text = "Countries" // of \(name of selected coninent)
    }
    
    private func setupLayout() {
        view.addSubview(continentCountryName)
        view.addSubview(collectionView)
        
        continentCountryName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top).inset(-15)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(continentCountryName.snp.bottom).inset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(-15)
        }
    }
}
