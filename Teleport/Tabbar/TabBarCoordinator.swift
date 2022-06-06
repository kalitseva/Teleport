//
//  TabBarCoordinator.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//

import RxSwift
import RxCocoa

final class TabBarCoordinator {

    enum Flow {
        case exitAppToRoot
    }

    // MARK: Public properties

    let bag = DisposeBag()
    let flow = PublishRelay<Flow>()
    let countryCoordinator = CountryCoordinator()
    let searchCoordinator = SearchCoordinator()
    let continentsCoordinator = ContinentsCoordinator()
    let timezonesCoordinator = TimezonesCoordinator()

    // MARK: Private properties

    private let tabBarController = TabBarController()

    // MARK: Public methods

    @discardableResult
    func start() -> UITabBarController {
        setTabControllers(for: tabBarController)
        coordinatorsPopToRoot()
        return tabBarController
    }


    // MARK: Private methods

    private func setTabControllers(for tabBarController: TabBarController) {
        tabBarController.viewControllers = [countryCoordinator.start(), searchCoordinator.start(), continentsCoordinator.start(), timezonesCoordinator.start()]
    }


 
    private func coordinatorsPopToRoot() {
        tabBarController
            .customTabBarView
            .flow
            .bind { [weak self] flow in
                guard let self = self else { return }
                switch flow {
                case .countries:
                   return
                   // self.countryCoordinator.navigationController?.popToRootViewController(animated: false)
                case .cities:
                    return
                   // self.continentsCoordinator.navigationController?.popToRootViewController(animated: false)
                case .search, .timezones:
                    let vc = ViewController()
                    self.tabBarController.present(vc, animated: true)
                }
            }
            .disposed(by: tabBarController.customTabBarView.bag)
    }
}

