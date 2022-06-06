//
//  AppCoordinator.swift
//  Teleport
//
//  Created by Майя Калицева on 12.05.2022.
//

import RxSwift

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}

class AppCoordinator: Coordinator {

    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    let tabBarCoordinator = TabBarCoordinator()
    

    init(navCon : UINavigationController) {
        self.navigationController = navCon
        start()
    }

    func start() {
        tabBarCoordinator.start()
        print("start")
    }
}
