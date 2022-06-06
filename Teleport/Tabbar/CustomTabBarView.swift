//
//  CustomTabBarView.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//


import RxSwift
import RxCocoa

final class CustomTabBarView: UIView {
    
    enum Flow: Int {
        case countries
        case search
        case cities
        case timezones
    }
    
    // MARK: - Public properties
    
    let flow = PublishRelay<Flow>()
    let bag = DisposeBag()
    let onItemTapped = PublishRelay<Int>()
    
    // MARK: - Private properties
    
    private var buttons: [UIButton] = []
    private var activeItem: Int = 0
    
    // MARK: - Initializers
    
    convenience init(menuItems: [TabItem]) {
        self.init(frame: .zero)
        setupTabItems(menuItems: menuItems)
        isUserInteractionEnabled = true
        setNeedsLayout()
        layoutIfNeeded()
        activateTab(tab: 0)
        buttons[0].isSelected = true
    }
    
    // MARK: - Private Methods
    
    private func setupTabItems(menuItems: [TabItem]) {
        for item in 0 ..< menuItems.count {
            let centerXAnchor = (UIScreen.main.bounds.width / 4) * (CGFloat(item) + 1) - (UIScreen.main.bounds.width / 9)
            let tabBarItem = self.createTabItem(item: menuItems[item])
            tabBarItem.tag = item
            tabBarItem.translatesAutoresizingMaskIntoConstraints = false
            tabBarItem.clipsToBounds = true
            self.addSubview(tabBarItem)
            self.buttons.append(tabBarItem)

            tabBarItem.snp.makeConstraints { make in
                make.size.equalTo(40)
                make.centerX.equalTo(centerXAnchor)
                make.centerY.equalTo(snp.bottom).offset(-30)
            }
        }
    }
    
    private func createTabItem(item: TabItem) -> UIButton {
        let tabBarButton = UIButton(frame: CGRect.zero)
        tabBarButton.isUserInteractionEnabled = true
        tabBarButton.setImage(item.icon, for: .normal)
        tabBarButton.setImage(item.iconForActive, for: .selected)
        tabBarButton.contentHorizontalAlignment = .fill
        tabBarButton.contentVerticalAlignment = .fill
        tabBarButton.contentMode = .scaleAspectFit
        tabBarButton.translatesAutoresizingMaskIntoConstraints = false
        bindButton(tabBarButton)
        return tabBarButton
    }
    
    private func bindButton(_ sender: UIButton) {
        sender.rx.tap
            .compactMap { [weak sender] _ -> Flow? in
                guard let sender = sender else { return nil }
                self.deselectAll()
                sender.isSelected = true
                return Flow(rawValue: sender.tag)
            }
            .do(onNext: { [weak self] in
                self?.switchTab(to: $0.rawValue)
            })
            .bind(to: flow)
            .disposed(by: bag)
    }
    
    private func switchTab(to: Int) {
        self.activateTab(tab: to)
    }
    
    private func activateTab(tab: Int) {
        onItemTapped.accept(tab)
        self.activeItem = tab
    }
    
    private func deselectAll() {
        buttons.forEach {
            $0.isSelected = false
        }
    }
}

