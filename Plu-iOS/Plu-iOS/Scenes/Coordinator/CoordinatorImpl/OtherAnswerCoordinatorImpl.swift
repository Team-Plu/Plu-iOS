//
//  OtherAnswerCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit

final class OtherAnswerCoordinatorImpl: OtherAnswersCoordinator {
    
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showOtherAnswersViewController() {
        let otherAnswerViewController = OthersAnswerViewController(coordinator: self)
        self.navigationController.pushViewController(otherAnswerViewController, animated: true)
    }
    
    func showAnswerDetailViewController() {
        let answerDetailCoordinator = AnswerDetailCoordinatorImpl(navigationController: self.navigationController)
        children.append(answerDetailCoordinator)
        answerDetailCoordinator.parentCoordinator = self
        answerDetailCoordinator.showAnswerDetailViewController()
    }
    
    func pop() {
        self.navigationController.popViewController(animated: true)
        parentCoordinator?.childDidFinish(self)
    }
}
