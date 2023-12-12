//
//  TabBarCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit


final class TabBarCoordinatorImpl: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    
}

private extension TabBarCoordinatorImpl {
    func startTodayQuestionCoordinator(_ navi: UINavigationController, from parent: Coordinator?) {
        let todayQuestionCoordinator = TodayQuestionCoordinatorImpl(navigationController: navi)
        todayQuestionCoordinator.parentCoordinator = parent
        parent?.children.append(todayQuestionCoordinator)
        todayQuestionCoordinator.showTodayQuestionViewController()
    }
    
    func startRecordCoordinator(_ navi: UINavigationController, from parent: Coordinator?) {
        let recordCoordinator = RecordCoordinatorImpl(navigationController: navi)
        recordCoordinator.parentCoordinator = parent
        parent?.children.append(recordCoordinator)
        recordCoordinator.showRecordViewController()
    }
}
