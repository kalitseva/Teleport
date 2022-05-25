//
//  UrbanCitiesViewController.swift
//  Teleport
//
//  Created by Майя Калицева on 24.05.2022.
//

import RxSwift
import RxRelay

final class UrbanCitiesViewController: UIViewController {
    
    // MARK: Public Properties
    
    private(set) var bag = DisposeBag()
    
    // MARK: Private Properties
    
    private let viewModel: UrbanCitiesViewModel
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 50)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        let cvc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cvc.backgroundColor = .white
        cvc.showsHorizontalScrollIndicator = false
        cvc.registerCells(withModels: UrbanAreasCollectionCellViewModel.self)
        return cvc
    }()
    
    // MARK: - Init

    init(viewModel: UrbanCitiesViewModel) {
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

    private func setupLayout() {
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
    }
}

