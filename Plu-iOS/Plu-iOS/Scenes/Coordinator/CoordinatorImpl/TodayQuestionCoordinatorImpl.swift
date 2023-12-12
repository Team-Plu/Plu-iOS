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
        let todayQuestionViewController = TodayQuestionViewController()
        self.navigationController.pushViewController(todayQuestionViewController, animated: true)
    }
    
    func showMyPageViewController() {
        <#code#>
    }
    
    func showMyAnswerViewController() {
        <#code#>
    }
    
    func showOtherAnswersViewController() {
        <#code#>
    }
    
    func presentAlarmPopUpViewController() {
        <#code#>
    }
}
