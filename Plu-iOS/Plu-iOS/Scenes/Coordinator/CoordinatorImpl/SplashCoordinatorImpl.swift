//
//  SplashCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit


final class SplashCoordinatorImpl: SplashCoordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showSplashViewController() {
        let splashViewController = SplashViewController(coordinator: self)
        self.navigationController.pushViewController(splashViewController, animated: false)
    }
    
    func showTabbarViewContoller() {
        let tabbarCoordinator = TabBarCoordinatorImpl(navigationController: navigationController)
        children.removeAll()
        tabbarCoordinator.parentCoordinator = self
        tabbarCoordinator.showTabbarController()
    }
    
    func showLoginViewController() {
        let authCoordinator = AuthCoordinatorImpl(navigationController: navigationController)
        children.removeAll()
        authCoordinator.parentCoordinator = self
        children.append(authCoordinator)
        authCoordinator.showLoginViewController()
    }
}
