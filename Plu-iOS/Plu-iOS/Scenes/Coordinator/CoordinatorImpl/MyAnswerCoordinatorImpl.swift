//
//  MyAnswerCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/12.
//

import UIKit
import Combine

final class MyAnswerCoordinatorImpl: MyAnswerCoordinator {
    var myAnswerSubject = PassthroughSubject<Void, Never>()
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
        let manager = RegisterPopUpManagerImpl()
        let viewModel = RegisterPopUpViewModelImpl(manager: manager)
        viewModel.delegate = self
        let registerPopUpViewController = RegisterPopUpViewController(viewModel: viewModel)
        self.navigationController?.present(registerPopUpViewController, animated: true)
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

extension MyAnswerCoordinatorImpl: RegisterPopUpNavigation {
    func dismiss() {
        self.navigationController?.dismiss(animated: true)
    }
    
    func completeButtonTapped() {
        self.navigationController?.dismiss(animated: true) {
            self.myAnswerSubject.send(())
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
