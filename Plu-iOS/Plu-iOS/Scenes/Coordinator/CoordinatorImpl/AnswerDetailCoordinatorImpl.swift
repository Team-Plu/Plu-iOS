//
//  AnswerDetailCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit


final class AnswerDetailCoordinatorImpl: AnswerDetailCoordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showAnswerDetailViewController() {
        let answerDetailViewController = AnswerDetailViewController()
        self.navigationController.pushViewController(answerDetailViewController, animated: true)
    }
    
    func pop() {
        self.navigationController.popViewController(animated: true)
        self.parentCoordinator?.childDidFinish(self)
    }
    
}
