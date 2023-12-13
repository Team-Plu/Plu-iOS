//
//  RecordCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/12.
//

import UIKit

final class RecordCoordinatorImpl: RecordCoordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showRecordViewController() {
        let recordViewController = RecordViewController(coordinator: self)
        self.navigationController.pushViewController(recordViewController, animated: true)
    }
    
    func showMyPageViewController() {
        print("✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅")
    }
    
    func presentSelectMonthPopUpViewController() {
        let popUpCoordinator = PopUpCoordinatorImpl(navigationController: navigationController)
        popUpCoordinator.selectMonthDelegate = self
        popUpCoordinator.parentCoordinator = self
        children.append(popUpCoordinator)
        
        popUpCoordinator.show(type: .selectMonth)
    }
    
    func showAnswerDetailViewController() {
        let answerDetailCoordinator = AnswerDetailCoordinatorImpl(navigationController: navigationController)
        answerDetailCoordinator.showAnswerDetailViewController()
        children.append(answerDetailCoordinator)
        answerDetailCoordinator.parentCoordinator = self
    }
}

extension RecordCoordinatorImpl: SelectMonthDelegate {
    func passYearAndMonth(_ input: String) {
        print("필터 입력완료: \(input)")
    }
    
}
