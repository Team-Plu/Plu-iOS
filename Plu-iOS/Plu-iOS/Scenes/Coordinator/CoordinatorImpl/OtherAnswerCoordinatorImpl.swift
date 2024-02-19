//
//  OtherAnswerCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit

final class OtherAnswerCoordinatorImpl: OtherAnswersCoordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showOtherAnswersViewController() {
        let manager = OthersAnswerManagerImpl()
        let viewModel = OthersAnswerViewModelImpl(manager: manager)
        viewModel.delegate = self
        let otherAnswerViewController = OthersAnswerViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(otherAnswerViewController, animated: true)
    }
    
    func showAnswerDetailViewController(id: Int) {
        let answerDetailCoordinator = AnswerDetailCoordinatorImpl(navigationController: self.navigationController)
        answerDetailCoordinator.showAnswerDetailViewController(id: id)
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension OtherAnswerCoordinatorImpl: OthersAnswerNavigation {
    func tableViewCellTapped(id: Int) {
        self.showAnswerDetailViewController(id: id)
    }
    
    func navigationBackButtonTapped() {
        self.pop()
    }
    
}
