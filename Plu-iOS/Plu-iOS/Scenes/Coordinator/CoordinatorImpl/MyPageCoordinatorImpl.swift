//
//  MyPageCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit

final class MyPageCoordinatorImpl: MyPageCoordinator {
    func showMyPageViewController() {
        let mypageViewController = MyPageViewController(coordinator: self)
        self.navigationController.pushViewController(mypageViewController, animated: true)
    }
    
    func presentAlarmPopUpViewController() {
        let popUpCoordinator = PopUpCoordinatorImpl(navigationController: self.navigationController)
        popUpCoordinator.show(type: .alarm)
        children.append(popUpCoordinator)
        popUpCoordinator.parentCoordinator = self
    }
    
    func showProfileEditViewController() {
        let profileEditViewController = NicknameEditViewController()
        self.navigationController.pushViewController(profileEditViewController, animated: true)
    }
    
    func showResignViewController() {
        let resignViewController = ResignViewController()
        self.navigationController.pushViewController(resignViewController, animated: true)
    }
    
    
    func pop<T: UIViewController>(taype: T.Type) {
        self.navigationController.popViewController(animated: true)
        if type(of: self.navigationController.viewControllers.first!) == taype {
            parentCoordinator?.childDidFinish(self)
            
        }
    }
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
}
