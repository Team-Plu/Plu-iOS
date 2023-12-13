//
//  TabbarViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//  Copyright (c) 2023 Tabbar. All rights reserved.
//

import UIKit

import SnapKit

final class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
        setTabBarUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setTabBarHeight()
    }
}

private extension TabbarViewController {
    
    func setTabBarHeight() {
        tabBar.frame.size.height = 100
        tabBar.frame.origin.y = view.frame.height - 100
    }
    
    func setTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        tabBarAppearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        let _ = self.setTabBarItemAppearnce()
        self.tabBar.standardAppearance = tabBarAppearance
    }
    
    func setTabBarItemAppearnce() -> UITabBarItemAppearance {
        let tabbarItemAppearance = UITabBarItemAppearance()
        tabbarItemAppearance.normal.titleTextAttributes = [.font: UIFont.suite(.tabbar)]
        tabbarItemAppearance.selected.titleTextAttributes = [.font: UIFont.suite(.tabbar)]
        return tabbarItemAppearance
    }
    
    func setTabBarUI() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .designSystem(.gray700)
        tabBar.layer.applyShadow()
        tabBar.layer.cornerRadius = tabBar.frame.height * 0.41
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

extension UINavigationController {
    func makeTabBar(title: String,
                    tabBarImg: UIImage,
                    tabBarSelectedImg: UIImage,
                    renderingMode: UIImage.RenderingMode) {
        
        self.isNavigationBarHidden = true
        self.tabBarItem = UITabBarItem(title: title,
                                       image: tabBarImg.withRenderingMode(renderingMode),
                                       selectedImage: tabBarSelectedImg.withRenderingMode(renderingMode))
    }
    
    
}


