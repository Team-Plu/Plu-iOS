//
//  MyAnswerCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/12.
//

import UIKit

final class MyAnswerCoordinatorImpl: MyAnswerCoordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showMyAnswerViewController() {
        let viewModel = MyAnswerViewModelImpl()
        viewModel.delegate = self
        let myAnswerViewController = MyAnswerViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(myAnswerViewController, animated: true)
    }
    
    func presentRegisterPopUpViewController(answer: String) {
        let popUpCoordinator = PopUpCoordinatorImpl(navigationController: self.navigationController)
        popUpCoordinator.presentRegisterPopUp()
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MyAnswerCoordinatorImpl: MyAnswerNavigation {
    func completeButtonTapped(answer: String) {
        self.presentRegisterPopUpViewController(answer: answer)
    }
}
