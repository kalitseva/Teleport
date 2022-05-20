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
        navigationController.setViewControllers([vc], animated: false)
        return navigationController
    }
    /*
    private func showAllUrbans() {
        let vm = UrbanAreasViewModel(service: service)
        let vc = UrbanAreasViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: false)
    }
     */
}
