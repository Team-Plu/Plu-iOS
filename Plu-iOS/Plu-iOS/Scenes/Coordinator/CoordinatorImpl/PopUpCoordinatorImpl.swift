//
//  PopUpCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/12.
//

import UIKit

protocol SelectMonthDelegate: AnyObject {
    func passYearAndMonth(year: Int, month: Int)
}

protocol AlarmDelegate: AnyObject {
    func isAccept()
}

protocol RegisterDelegate: AnyObject {
    func register()
}

final class PopUpCoordinatorImpl: PopUpCoordinator {

    
    weak var selectMonthDelegate: SelectMonthDelegate?
    weak var alarmDelegate: AlarmDelegate?
    weak var registerDelgate: RegisterDelegate?
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    
    func show(type: PopUpType) {
        switch type {
        case .alarm(let type):
            let viewModel = AlarmPopUpViewModelImpl(coordinator: self, type: type)
            let alarmPopUpViewController = AlarmPopUpViewController(viewModel: viewModel)
            self.navigationController?.present(alarmPopUpViewController, animated: true)
        case .register:
            let viewModel = RegisterPopUpViewModelImpl(coordinator: self)
            let registerPopUpViewController = RegisterPopUpViewController(viewModel: viewModel)
            self.navigationController?.present(registerPopUpViewController, animated: true)
        case .selectMonth:
            let viewModel = SelectMonthPopUpViewModelImpl(coordinator: self)
            let selectMonthPopUpViewController = SelectYearAndMonthPopUpViewController(viewModel: viewModel)
            self.navigationController?.present(selectMonthPopUpViewController, animated: true)
        }
    }
    
    
    func accept(type: PopUpType) {
        self.navigationController?.dismiss(animated: true) {
            switch type {
            case .alarm:
                self.alarmDelegate?.alarmAccept(true)
            case .register:
                self.registerDelgate?.register(true)
            case .selectMonth(let year, let month):
                self.selectMonthDelegate?.passYearAndMonth(year: year, month: month)
            }
        }
        self.navigationController?.dismiss(animated: true)
    }
    
    func dismiss() {
        self.navigationController?.dismiss(animated: true)
    }
}
