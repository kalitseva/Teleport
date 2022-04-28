//
//  TabBarCoordinator.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//

import RxSwift
import RxCocoa

final class CountryCoordinator {

    let service = Service()
    private(set) weak var navigationController: UINavigationController?
    
    func start() -> UINavigationController {
        let vm = CountriesViewModel(service: service)
        let vc = CountriesViewController(viewModel: vm)
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        navigationController.setViewControllers([vc], animated: false)
        return navigationController
    }
}

final class TabBarCoordinator {

    enum Flow {
        case exitAppToRoot
    }

    // MARK: Public properties

    let bag = DisposeBag()
    let flow = PublishRelay<Flow>()
    let countryCoordinator = CountryCoordinator()

    // MARK: Private properties

    private let tabBarController = TabBarController()

    // MARK: Public methods

    @discardableResult
    func start() -> UITabBarController {
        setTabControllers(for: tabBarController)
        coordinatorsPopToRoot()
      //  tabBarController.selectedIndex = 0
        return tabBarController
    }


    // MARK: Private methods

    private func setTabControllers(for tabBarController: TabBarController) {
        tabBarController.viewControllers = [countryCoordinator.start()]
    }


    private func coordinatorsPopToRoot() {
        tabBarController
            .customTabBarView
            .flow
            .bind { [weak self] flow in
                guard let self = self else { return }
                switch flow {
                case .search, .cities, .timezones:
                    return
                case .countries:
                    let countryVM = CountriesViewModel(service: self.countryCoordinator.service)
                    let countryVC = CountriesViewController(viewModel: countryVM)
                    self.tabBarController.present(countryVC, animated: true)
                    
                }
            }
            .disposed(by: tabBarController.customTabBarView.bag)
    }
}

