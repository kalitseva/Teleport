//
//  ContinentsCoordinator.swift
//  Teleport
//
//  Created by Майя Калицева on 11.05.2022.
//

import RxCocoa
import RxSwift

final class ContinentsCoordinator {
    
    // MARK: - Private Properties

    private let service = Service()
    private weak var navigationController: UINavigationController?
    
    // MARK: - Public Methods
    
    func start() -> UINavigationController {
        let vm = ContinentsViewModel(service: service)
        let vc = ContinentsViewController(viewModel: vm)
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        navigationController.setViewControllers([vc], animated: false)
        bindContinentsViewModel(viewModel: vm)
        return navigationController
    }
    
    // MARK: - Private Methods
    
    private func showCountries(id: String) {
        let vm = ContinentCountryViewModel(service: service, id: id)
        let vc = ContinentCountryViewController(viewModel: vm)
        print("push")
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func bindContinentsViewModel(viewModel: ContinentsViewModel) {
        viewModel
            .flow
            .bind { [weak self] flow in
                switch flow {
                case .onContinentTap(let id):
                    self?.showCountries(id: id)
                }
            }
            .disposed(by: viewModel.bag)
    }
}
