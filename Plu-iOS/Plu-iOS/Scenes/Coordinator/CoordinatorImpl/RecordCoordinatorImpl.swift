//
//  RecordCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/12.
//

import UIKit

protocol RecordCoordinatorDelegate: AnyObject {
    func getYearAndMonth(year: Int, month: Int)
}

final class RecordCoordinatorImpl: RecordCoordinator {
    
    weak var delegate: RecordCoordinatorDelegate?
    
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
        popUpCoordinator.show(type: .selectMonth(year: .zero, month: .zero))
    }
    
    func showAnswerDetailViewController() {
        let answerDetailCoordinator = AnswerDetailCoordinatorImpl(navigationController: self.navigationController)
        answerDetailCoordinator.showAnswerDetailViewController()
    }
}

extension RecordCoordinatorImpl: SelectMonthDelegate {
    func passYearAndMonth(year: Int, month: Int) {
        self.delegate?.getYearAndMonth(year: year, month: month)
    }
}
