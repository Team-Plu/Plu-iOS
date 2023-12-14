//
//  TabBarCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit

final class TabBarCoordinatorImpl: TabbarCoordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showTabbarController() {
        let tabbarController = TabbarViewController()
        let todayQuestionNavigationController = UINavigationController()
        let recordNavigationController = UINavigationController()
        startRecordCoordinator(recordNavigationController)
        startTodayQuestionCoordinator(todayQuestionNavigationController)
        
        tabbarController.viewControllers = [todayQuestionNavigationController, recordNavigationController]
        
        navigationController?.viewControllers.removeAll()
        navigationController?.pushViewController(tabbarController, animated: false)
        navigationController?.isNavigationBarHidden = true
    }
}

private extension TabBarCoordinatorImpl {
    func startTodayQuestionCoordinator(_ navi: UINavigationController) {
        let todayQuestionCoordinator = TodayQuestionCoordinatorImpl(navigationController: navi)
        navi.makeTabBar(title: "오늘의 질문", tabBarImg: ImageLiterals.TabBar.homeInActivated, tabBarSelectedImg: ImageLiterals.TabBar.homeActivated, renderingMode: .alwaysOriginal)
        todayQuestionCoordinator.showTodayQuestionViewController()
    }
    
    func startRecordCoordinator(_ navi: UINavigationController) {
        let recordCoordinator = RecordCoordinatorImpl(navigationController: navi)
        navi.makeTabBar(title: "일기 기록", tabBarImg: ImageLiterals.TabBar.recordInActivated, tabBarSelectedImg: ImageLiterals.TabBar.recordActivated, renderingMode: .alwaysOriginal)
        recordCoordinator.showRecordViewController()
    }
}
