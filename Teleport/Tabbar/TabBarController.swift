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

    private let customTabbarHeight: CGFloat = 35
    private let tabItems: [TabItem] = [.countries, .search, .cities, .timezones]

    lazy var customTabBarView: CustomTabBarView = {
        let iv = CustomTabBarView(menuItems: tabItems)
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    override var childForStatusBarStyle: UIViewController? {
        return selectedViewController
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
        bindCustomTabbarView()
        setupCustomSafeAreaInsets()
    }

    // MARK: - Public Methods

    func setTabbarHidden(_ isHidden: Bool) {
        customTabBarView.isHidden = isHidden
    }

    // MARK: - Private Methods

    private func setupCustomSafeAreaInsets() {
        additionalSafeAreaInsets.bottom = customTabbarHeight
    }

    private func setupCustomTabBar() {
        tabBar.isHidden = true
        view.addSubview(customTabBarView)

        customTabBarView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
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

