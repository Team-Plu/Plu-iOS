//
//  TodayQuestionCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/12.
//

import UIKit

final class TodayQuestionCoordinatorImpl: TodayQuestionCoordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showTodayQuestionViewController() {
        let viewModel = TodayQuestionViewModelImpl(manager: TodayQuestionManagerStub())
        viewModel.delegate = self
        let todayQuestionViewController = TodayQuestionViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(todayQuestionViewController, animated: true)
    }
    
    func showMyPageViewController() {
        let mypageCoordinator = MyPageCoordinatorImpl(navigationController: self.navigationController)
        mypageCoordinator.showMyPageViewController()
    }
    
    func showMyAnswerViewController() {
        let myAnswerCoordinator = MyAnswerCoordinatorImpl(navigationController: self.navigationController)
        myAnswerCoordinator.showMyAnswerViewController()
    }
    
    func showOtherAnswersViewController() {
        let otherAnswerCoordinator = OtherAnswerCoordinatorImpl(navigationController: self.navigationController)
        otherAnswerCoordinator.showOtherAnswersViewController()
    }
    
//    func presentAlarmPopUpViewController() {
//        let popUpCoordinator = PopUpCoordinatorImpl(navigationController: self.navigationController)
////        popUpCoordinator.alarmDelegate = self
////        popUpCoordinator.show(type: .alarm(.todayQuestion))
//
//    }
}

//extension TodayQuestionCoordinatorImpl: AlarmDelegate {
//    func isAccept() {
//        print("알람 확인 버튼이 늘렸습니다")
//    }
//}

extension TodayQuestionCoordinatorImpl: TodayQuestionNavigation {
    func navigationRightButtonTapped() {
        self.showMyPageViewController()
    }
    
    func myAnswerButtonTapped() {
        self.showMyAnswerViewController()
    }
    
    func otherAnswerButtonTapped() {
        self.showOtherAnswersViewController()
    }
//    
//    func presentAlarmPopUp() {
//        self.presentAlarmPopUpViewController()
//    }
}
