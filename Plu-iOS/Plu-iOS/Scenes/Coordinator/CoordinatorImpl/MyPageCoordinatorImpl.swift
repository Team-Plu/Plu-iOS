//
//  MyPageCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit

final class MyPageCoordinatorImpl: MyPageCoordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showMyPageViewController() {
        let mypageViewController = MyPageViewController(coordinator: self)
        self.navigationController?.pushViewController(mypageViewController, animated: true)
    }
    
    func presentAlarmPopUpViewController() {
        let popUpCoordinator = PopUpCoordinatorImpl(navigationController: self.navigationController)
        popUpCoordinator.show(type: .alarm)
    }
    
    func showProfileEditViewController() {
        let profileEditViewController = NicknameEditViewController()
        self.navigationController?.pushViewController(profileEditViewController, animated: true)
    }
    
    func showResignViewController() {
        let resignViewController = ResignViewController(coordinator: self)
        self.navigationController?.pushViewController(resignViewController, animated: true)
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
