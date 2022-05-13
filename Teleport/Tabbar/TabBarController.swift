//
//  TabBarController.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//

import RxSwift
import RxCocoa

final class TabBarController: UITabBarController {

    // MARK: - Public properties

    let bag = DisposeBag()

    // MARK: - Private properties

    private let customTabbarHeight: CGFloat = 55
    private let tabItems: [TabItem] = [.countries, .search, .cities, .timezones]

    lazy var customTabBarView: CustomTabBarView = {
        let iv = CustomTabBarView(menuItems: tabItems)
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .white
        return iv
    }()

    override var childForStatusBarStyle: UIViewController? {
        return selectedViewController
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindCustomTabbarView()
        setupCustomTabBar()
    }

    // MARK: - Private Methods

    private func setupCustomTabBar() {
        tabBar.isHidden = false
        view.addSubview(customTabBarView)

        customTabBarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(customTabbarHeight)
        }
        selectedIndex = 0
    }

    private func bindCustomTabbarView() {
        customTabBarView
            .onItemTapped
            .bind { [weak self] tab in
                self?.selectedIndex = tab
            }
            .disposed(by: customTabBarView.bag)
    }
}

