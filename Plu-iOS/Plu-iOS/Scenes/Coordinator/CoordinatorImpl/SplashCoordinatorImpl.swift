//
//  SplashCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit


final class SplashCoordinatorImpl: SplashCoordinator {

    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showSplashViewController() {
        let splashViewController = SplashViewController(coordinator: self)
        self.navigationController?.pushViewController(splashViewController, animated: false)
    }
    
    func showTabbarViewContoller() {
        let tabbarCoordinator = TabBarCoordinatorImpl(navigationController: self.navigationController)
        tabbarCoordinator.showTabbarController()
    }
    
    func showLoginViewController() {
        let authCoordinator = AuthCoordinatorImpl(navigationController: navigationController)
        authCoordinator.showLoginViewController()
    }
}
