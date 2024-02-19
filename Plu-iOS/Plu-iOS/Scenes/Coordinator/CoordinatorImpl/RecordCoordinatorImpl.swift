//
//  RecordCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/12.
//

import UIKit
import Combine

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
        let viewModel = SelectMonthPopUpViewModelImpl()
        viewModel.delegate = self
        let selectedYearAndMonthViewController = SelectYearAndMonthPopUpViewController(viewModel: viewModel)
        self.navigationController?.present(selectedYearAndMonthViewController, animated: true)
    }
    
    func showAnswerDetailViewController(id: Int) {
        let answerDetailCoordinator = AnswerDetailCoordinatorImpl(navigationController: self.navigationController)
        answerDetailCoordinator.showAnswerDetailViewController(id: id)
    }
}

extension RecordCoordinatorImpl: SelectYearAndMonthNavigation {
    func confirmButtonTapped(input: FilterDate) {
        self.navigationController?.dismiss(animated: true) {
            self.yearAndMonthSubject.send(input)
        }
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
