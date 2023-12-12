//
//  TodayQuestionCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/12.
//

import UIKit

final class TodayQuestionCoordinatorImpl: TodayQuestionCoordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showTodayQuestionViewController() {
        let todayQuestionViewController = TodayQuestionViewController(coordinator: self)
        self.navigationController.pushViewController(todayQuestionViewController, animated: true)
    }
    
    func showMyPageViewController() {
        
    }
    
    func showMyAnswerViewController() {
        let myAnswerCoordinator = MyAnswerCoordinatorImpl(navigationController: self.navigationController)
        myAnswerCoordinator.showMyAnswerViewController()
        children.append(myAnswerCoordinator)
    }
    
    func showOtherAnswersViewController() {
        print("✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅")
    }
    
    func presentAlarmPopUpViewController() {
        let popUpCoordinator = PopUpCoordinatorImpl(navigationController: self.navigationController)
        popUpCoordinator.alarmDelegate = self
        popUpCoordinator.show(type: .alarm)
        children.append(popUpCoordinator)
    }
}

extension TodayQuestionCoordinatorImpl: AlarmDelegate {
    func alarmAccept(_ input: Bool) {
        print("알람 확인 버튼이 늘렸습니다")
    }
}
