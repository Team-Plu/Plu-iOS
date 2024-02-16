//
//  SplashCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit


final class SplashCoordinatorImpl {

    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showSplashViewController() {
        let splashViewController = SplashViewController()
        splashViewController.delegate = self
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

extension SplashCoordinatorImpl: SplashNavigation {
    func goToLogin() {
        self.showLoginViewController()
    }
    
    func goToMain() {
        self.showTabbarViewContoller()
    }
}
