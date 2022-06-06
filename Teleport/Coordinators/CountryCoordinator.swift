//
//  CountryCoordinator.swift
//  Teleport
//
//  Created by Майя Калицева on 11.05.2022.
//

import RxSwift
import RxCocoa

final class CountryCoordinator {

    let service = Service()
    private weak var navigationController: UINavigationController?
    
    func start() -> UINavigationController {
        let vm = CountriesViewModel(service: service)
        let vc = CountriesViewController(viewModel: vm)
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        navigationController.setViewControllers([vc], animated: false)
        return navigationController
    }
}
