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

final class SearchCoordinator {
    
    let service = Service()
    private(set) weak var navigationController: UINavigationController?
    
    func start() -> UINavigationController {
        let vc = ViewController()
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        navigationController.setViewControllers([vc], animated: false)
        return navigationController
    }
}

final class CitiesCoordinator {
    
    let service = Service()
    private(set) weak var navigationController: UINavigationController?
    
    func start() -> UINavigationController {
        let vc = ViewController()
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        navigationController.setViewControllers([vc], animated: false)
        return navigationController
    }
}

final class TimezonesCoordinator {
    
    let service = Service()
    private(set) weak var navigationController: UINavigationController?
    
    func start() -> UINavigationController {
        let vc = ViewController()
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
    let searchCoordinator = SearchCoordinator()
    let citiesCoordinator = CitiesCoordinator()
    let timezonesCoordinator = TimezonesCoordinator()

    // MARK: Private properties

    private let tabBarController = TabBarController()

    // MARK: Public methods

    @discardableResult
    func start() -> UITabBarController {
        setTabControllers(for: tabBarController)
     //   coordinatorsPopToRoot() THINK ABOUT USAGE LATER
        return tabBarController
    }


    // MARK: Private methods

    private func setTabControllers(for tabBarController: TabBarController) {
        tabBarController.viewControllers = [countryCoordinator.start(), searchCoordinator.start(), citiesCoordinator.start(), timezonesCoordinator.start()]
    }

/*
 THINK ABOUT USAGE LATER
    private func coordinatorsPopToRoot() {
        tabBarController
            .customTabBarView
            .flow
            .bind { [weak self] flow in
                guard let self = self else { return }
                switch flow {
                case .countries:
                    let countryVM = CountriesViewModel(service: self.countryCoordinator.service)
                    let countryVC = CountriesViewController(viewModel: countryVM)
                  //  self.tabBarController.present(countryVC, animated: true)
                        //self.countryCoordinator.start()
                case .search, .cities, .timezones:
                    let vc = ViewController()
                  //  self.tabBarController.present(vc, animated: true)
                    //self.searchCoordinator.start()
                    print("tap")
                }
            }
            .disposed(by: tabBarController.customTabBarView.bag)
    }
 */
}

