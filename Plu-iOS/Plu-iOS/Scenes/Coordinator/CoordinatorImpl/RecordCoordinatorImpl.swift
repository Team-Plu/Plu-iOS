//
//  RecordCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/12.
//

import UIKit
import Combine

protocol RecordCoordinatorDelegate: AnyObject {
    func getYearAndMonth(year: Int, month: Int)
}

final class RecordCoordinatorImpl: RecordCoordinator {

    var yearAndMonthSubject = PassthroughSubject<FilterDate, Never>()
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showRecordViewController() {
        let manager = RecordManagerImpl()
        let viewModel = RecordViewModelImpl(manager: manager)
        viewModel.delegate = self
        let recordViewController = RecordViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(recordViewController, animated: true)
    }
    
    func showMyPageViewController() {
        let myPageCoordinator = MyPageCoordinatorImpl(navigationController: self.navigationController)
        myPageCoordinator.showMyPageViewController()
    }
    
    func presentSelectMonthPopUpViewController() {
        let popUpCoordinator = PopUpCoordinatorImpl(navigationController: self.navigationController)
        popUpCoordinator.selectMonthDelegate = self
        popUpCoordinator.show(type: .selectMonth(date: .empty))
    }
    
    func showAnswerDetailViewController(id: Int) {
        let answerDetailCoordinator = AnswerDetailCoordinatorImpl(navigationController: self.navigationController)
        answerDetailCoordinator.showAnswerDetailViewController(id: id)
    }
}

//TODO: 수정 필요
extension RecordCoordinatorImpl: SelectMonthDelegate {
    func passYearAndMonth(date: FilterDate) {
        self.yearAndMonthSubject.send(date)
//        self.delegate?.getYearAndMonth(year: year, month: month)
    }
}

extension RecordCoordinatorImpl: RecordNavigation {
    func dateFilterButtonTapped() {
        self.presentSelectMonthPopUpViewController()
    }
    
    func tableViewCellTapped(id: Int) {
        self.showAnswerDetailViewController(id: id)
    }
    
    func navigationRightButtonTapped() {
        self.showMyPageViewController()
    }
    
}
