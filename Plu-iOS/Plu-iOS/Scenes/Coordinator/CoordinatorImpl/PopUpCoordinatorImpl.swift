//
//  PopUpCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/12.
//

import UIKit

protocol SelectMonthDelegate: AnyObject {
    func passYearAndMonth(_ input: String)
}

protocol AlarmDelegate: AnyObject {
    func alarmAccept(_ input: Bool)
}

protocol RegisterDelegate: AnyObject {
    func register(_ input: Bool)
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
        case .alarm:
            let alarmPopUpViewController = AlarmPopUpViewController(coordinator: self)
            self.navigationController?.present(alarmPopUpViewController, animated: true)
        case .register:
            let registerPopUpViewController = RegisterPopUpViewController(coordinator: self)
            self.navigationController?.present(registerPopUpViewController, animated: true)
        case .selectMonth:
            let viewModel: SelectMonthPopUpViewModel = SelectMonthPopUpViewModelImpl(coordinator: self)
            let selectMonthPopUpViewController = SelectMonthPopUpViewController(viewModel: viewModel)
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
            case .selectMonth:
                self.selectMonthDelegate?.passYearAndMonth("날짜가 입력되었습니다")
            }
        }
    }
    
    func dismiss() {
        self.navigationController?.dismiss(animated: true)
    }
}
