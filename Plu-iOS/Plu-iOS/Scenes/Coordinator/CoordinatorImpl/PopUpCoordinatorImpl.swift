//
//  PopUpCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/12.
//

import UIKit

protocol SelectMonthDelegate: AnyObject {
    func passYearAndMonth(date: FilterDate)
}

protocol PopUpAlarmDelegate: AnyObject {
    func acceptButtonTapped()
}

final class PopUpCoordinatorImpl {
    
    weak var alaramDelegate: PopUpAlarmDelegate?
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func presentRegisterPopUp() {
        let manager = RegisterPopUpManagerImpl()
        let viewModel = RegisterPopUpViewModelImpl(manager: manager)
        viewModel.delegate = self
        let registerPopUpViewController = RegisterPopUpViewController(viewModel: viewModel)
        self.navigationController?.present(registerPopUpViewController, animated: true)
    }
    
    func presentSelectYearAndMonthPopUp() {
        let viewModel = SelectMonthPopUpViewModelImpl()
        let selectedYearAndMonthViewController = SelectYearAndMonthPopUpViewController(viewModel: viewModel)
        self.navigationController?.present(selectedYearAndMonthViewController, animated: true)
    }
    
    
}

extension PopUpCoordinatorImpl: RegisterPopUpNavigation {
    func dismiss() {
        self.navigationController?.dismiss(animated: true)
    }
    
    func completeButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension PopUpCoordinatorImpl: AlaramNavigation {
    func alarmContinueButtonTapped() {
        self.navigationController?.dismiss(animated: true) {
            self.alaramDelegate?.acceptButtonTapped()
        }
    }
    
    func alarmCancelButtonTapped() {
        self.navigationController?.dismiss(animated: true)
    }
}
