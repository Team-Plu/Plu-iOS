//
//  AppCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//


import UIKit

final class AppCoordinatorImpl: Coordinator {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func startSplashCoordinator() {
        let splashCoordinator = SplashCoordinatorImpl(navigationController: self.navigationController)
        splashCoordinator.showSplashViewController()
    }
}
