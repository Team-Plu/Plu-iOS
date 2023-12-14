//
//  RecordCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/12.
//

import UIKit

final class RecordCoordinatorImpl: RecordCoordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showRecordViewController() {
        let recordViewController = RecordViewController(coordinator: self)
        self.navigationController?.pushViewController(recordViewController, animated: true)
    }
    
    func showMyPageViewController() {
        let myPageCoordinator = MyPageCoordinatorImpl(navigationController: self.navigationController)
        myPageCoordinator.showMyPageViewController()
    }
    
    func presentSelectMonthPopUpViewController() {
        let popUpCoordinator = PopUpCoordinatorImpl(navigationController: self.navigationController)
        popUpCoordinator.selectMonthDelegate = self
        
        popUpCoordinator.show(type: .selectMonth)
    }
    
    func showAnswerDetailViewController() {
        let answerDetailCoordinator = AnswerDetailCoordinatorImpl(navigationController: self.navigationController)
        answerDetailCoordinator.showAnswerDetailViewController()
    }
}

extension RecordCoordinatorImpl: SelectMonthDelegate {
    func passYearAndMonth(_ input: String) {
        print("필터 입력완료: \(input)")
    }
}
