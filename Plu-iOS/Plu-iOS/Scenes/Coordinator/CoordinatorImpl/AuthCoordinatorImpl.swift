//
//  AuthCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit


final class AuthCoordinatorImpl: AuthCoordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showLoginViewController() {
        print("ㅇㄹㄴㅇ")
    }
    
    func showTabbarController() {
        print("ㅇㄹㄴㅇ")
    }
    
    func showOnboardingController() {
        print("ㅇㄹㄴㅇ")
    }
    
    func pop() {
        print("ㅇㄹㄴㅇ")
    }
    
}
