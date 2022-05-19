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
    let bag = DisposeBag()
    
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
    
    private func showCountries(id: String) {
        let vm = ContinentCountryViewModel(service: service, id: id)
        let vc = ContinentCountryViewController(viewModel: vm)
        bindCountriesViewModel(viewModel: vm)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func bindCountriesViewModel(viewModel: ContinentCountryViewModel) {
        viewModel
            .flow
            .bind { [weak self] flow in
                switch flow {
                case .onCountrySalaryTap(let country):
                    self?.showSalaries(id: country)
                }
            }
            .disposed(by: viewModel.bag)
    }
    
    private func showSalaries(id: String) {
        let vm = SalariesViewModel(service: service, id: id)
        let vc = SalariesViewController(viewModel: vm)
        bindSalariesViewModel(viewModel: vm)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func bindSalariesViewModel(viewModel: SalariesViewModel) {
        viewModel
            .flow
            .bind { [weak self] flow in
                switch flow {
                case .onEmptyCountry:
                    AlertController.noSalaryInfo {
                        self?.navigationController?.popToRootViewController(animated: false)
                    }
                }
            }
            .disposed(by: viewModel.bag)
    }
}
