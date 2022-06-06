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
    let continentsCoordinator = ContinentsCoordinator()
    let searchCoordinator = SearchCoordinator()
    let urbansCoordinator = UrbanAreasCoordinator()

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
        tabBarController.viewControllers = [continentsCoordinator.start(), searchCoordinator.start(), urbansCoordinator.start()]
    }


 
    private func coordinatorsPopToRoot() {
        tabBarController
            .customTabBarView
            .flow
            .bind { [weak self] flow in
                guard let self = self else { return }
                switch flow {
                case .countries, .cities, .search, .timezones:
                   return
                }
            }
            .disposed(by: tabBarController.customTabBarView.bag)
    }
}

