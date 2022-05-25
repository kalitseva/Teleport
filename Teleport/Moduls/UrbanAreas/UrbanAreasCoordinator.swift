//
//  TimezonesCoordinator.swift
//  Teleport
//
//  Created by Майя Калицева on 11.05.2022.
//

import RxSwift
import RxCocoa

final class UrbanAreasCoordinator {
    
    let service = Service()
    private weak var navigationController: UINavigationController?
    
    func start() -> UINavigationController {
        let vm = UrbanAreasViewModel(service: service)
        let vc = UrbanAreasViewController(viewModel: vm)
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        bindContinentsViewModel(viewModel: vm)
        navigationController.setViewControllers([vc], animated: false)
        return navigationController
    }

    private func bindContinentsViewModel(viewModel: UrbanAreasViewModel) {
        viewModel
            .flow
            .bind { [weak self] flow in
                switch flow {
                case .onUrbanTap(let href):
                    print("test tap")
                    self?.showDetails(id: href)
                }
            }
            .disposed(by: viewModel.bag)
    }
    
    private func showDetails(id: String) {
        let vm = DetailsUrbanAreaVM(service: service)
        let vc = DetailUrbanAreaVC(viewModel: vm)
        vm.getUrbansScoresList(id: id)
        navigationController?.pushViewController(vc, animated: false)
    }
}
