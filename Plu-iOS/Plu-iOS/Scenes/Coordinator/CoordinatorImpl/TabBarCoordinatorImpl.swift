//
//  TabBarCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit

final class TabBarCoordinatorImpl: TabbarCoordinator {

    weak var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showTabbarController() {
        let tabbarController = TabbarViewController()
        let todayQuestionNavigationController = UINavigationController()
        let recordNavigationController = UINavigationController()
        startRecordCoordinator(recordNavigationController, from: parentCoordinator)
        startTodayQuestionCoordinator(todayQuestionNavigationController, from: parentCoordinator)
        
        tabbarController.viewControllers = [todayQuestionNavigationController, recordNavigationController]
        
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(tabbarController, animated: false)
        navigationController.isNavigationBarHidden = true
    }
}

private extension TabBarCoordinatorImpl {
    func startTodayQuestionCoordinator(_ navi: UINavigationController, from parent: Coordinator?) {
        let todayQuestionCoordinator = TodayQuestionCoordinatorImpl(navigationController: navi)
        todayQuestionCoordinator.parentCoordinator = parent
        navi.makeTabBar(title: "오늘의 질문", tabBarImg: ImageLiterals.TabBar.homeInActivated, tabBarSelectedImg: ImageLiterals.TabBar.homeActivated, renderingMode: .alwaysOriginal)
        parent?.children.append(todayQuestionCoordinator)
        todayQuestionCoordinator.showTodayQuestionViewController()
    }
    
    func startRecordCoordinator(_ navi: UINavigationController, from parent: Coordinator?) {
        let recordCoordinator = RecordCoordinatorImpl(navigationController: navi)
        recordCoordinator.parentCoordinator = parent
        navi.makeTabBar(title: "일기 기록", tabBarImg: ImageLiterals.TabBar.recordInActivated, tabBarSelectedImg: ImageLiterals.TabBar.recordActivated, renderingMode: .alwaysOriginal)
        parent?.children.append(recordCoordinator)
        recordCoordinator.showRecordViewController()
    }
}
