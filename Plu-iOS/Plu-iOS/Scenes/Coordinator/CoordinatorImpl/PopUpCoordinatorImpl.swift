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
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func show(type: PopUpType) {
        switch type {
        case .alarm:
            let alarmPopUpViewController = AlarmPopUpViewController(coordinator: self)
            self.navigationController.present(alarmPopUpViewController, animated: true)
        case .register:
            let registerPopUpViewController = RegisterPopUpViewController()
            self.navigationController.present(registerPopUpViewController, animated: true)
        case .selectMonth:
            let selectMonthPopUpViewController = SelectMonthPopUpViewController()
            self.navigationController.present(selectMonthPopUpViewController, animated: true)
        }
    }
    
    
    func accept(type: PopUpType) {
        switch type {
        case .alarm:
            self.alarmDelegate?.alarmAccept(true)
        case .register:
            self.registerDelgate?.register(true)
        case .selectMonth:
            self.selectMonthDelegate?.passYearAndMonth("날짜가입력되었습니다")
        }
        self.navigationController.dismiss(animated: true) {
            self.parentCoordinator?.childDidFinish(self)
        }
    }
    
    func dismiss() {
        self.navigationController.dismiss(animated: true) {
            self.parentCoordinator?.childDidFinish(self)
        }
    }
}
