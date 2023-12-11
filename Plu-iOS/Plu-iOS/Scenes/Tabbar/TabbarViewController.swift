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
        
        setTabBar()
        setTabBarAppearance()
        setTabBarUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setTabBarHeight()
    }
}

private extension TabbarViewController {
    func setTabBar() {
        let todayQuestion = makeTabBar(viewController: TodayQuestionViewController(),
                                       title: "오늘의 질문",
                                       tabBarImg: ImageLiterals.TabBar.homeInActivated,
                                       tabBarSelectedImg: ImageLiterals.TabBar.homeActivated,
                                       renderingMode: .alwaysOriginal)
        
        let myAnswer = makeTabBar(viewController: MyAnswerViewController(),
                                  title: "일기 기록",
                                  tabBarImg: ImageLiterals.TabBar.recordInActivated,
                                  tabBarSelectedImg: ImageLiterals.TabBar.recordActivated,
                                  renderingMode: .alwaysOriginal)
        
        let tabs = [todayQuestion, myAnswer]
        
        self.setViewControllers(tabs, animated: false)
    }
    
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

private extension TabbarViewController {
    func makeTabBar(viewController: UIViewController,
                                title: String,
                                tabBarImg: UIImage,
                                tabBarSelectedImg: UIImage,
                                renderingMode: UIImage.RenderingMode) -> UIViewController {
            
            let tab = UINavigationController(rootViewController: viewController)
            tab.isNavigationBarHidden = true
            tab.tabBarItem = UITabBarItem(title: title,
                                          image: tabBarImg.withRenderingMode(renderingMode),
                                          selectedImage: tabBarSelectedImg.withRenderingMode(renderingMode))
            return tab
        }
}
