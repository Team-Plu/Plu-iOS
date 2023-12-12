//
//  MyPageCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import Foundation
import UIKit

final class MyPageCoordinatorImpl: MyPageCoordinator {
    func showMyPageViewController() {
        <#code#>
    }
    
    func presentAlarmPopUpViewController() {
        <#code#>
    }
    
    func showProfileEditViewController() {
        <#code#>
    }
    
    func showResignViewController() {
        <#code#>
    }
    
    
    func pop<T: UIViewController>(type: T.Type) {
        self.navigationController.popViewController(animated: true)
        let rootType = type(of: navigationController.viewControllers.first)
        if rootType == type {
            // 첫번째
            parentCoordinator?.childDidFinish(self)
        }
    }
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator]
    
    var navigationController: UINavigationController
    
    
}
