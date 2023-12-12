//
//  PopUpCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/12.
//

import UIKit

protocol PopUpDelegate: AnyObject {
    func passYearAndMonth(_ input: String)
}

final class PopUpCoordinatorImpl: PopUpCoordinator {
    weak var delegate: PopUpDelegate?
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func accept(type: PopUpType) {
        switch type {
        case .alarm:
            let alarmPopUpViewController = 
        case .register:
            <#code#>
        case .selecMonth:
            <#code#>
        }
    }
    
    func dismiss(yearAndMonth: String?) {
        self.navigationController.dismiss(animated: true) {
            if let yearAndMonth = yearAndMonth {
                self.delegate?.passYearAndMonth(yearAndMonth)
            }
            self.parentCoordinator?.childDidFinish(self)
        }
    }
}
