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
        let adaptor = OthersAnswerAdaptor(coordinator: self)
        let manager = OthersAnswerManagerImpl()
        let viewModel = OthersAnswerViewModelImpl(adaptor: adaptor, manager: manager)
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
