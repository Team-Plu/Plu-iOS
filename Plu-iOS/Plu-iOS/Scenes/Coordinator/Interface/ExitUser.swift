//
//  ExitUser.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/18.
//

import UIKit

protocol ExitUser {
    func exitUserToSplash()
}

extension ExitUser {
    func exitUserToSplash() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        let navigationController = UINavigationController()
        sceneDelegate.appCoordinator = AppCoordinatorImpl(navigationController: navigationController)
        sceneDelegate.appCoordinator?.startSplashCoordinator()
        sceneDelegate.window?.rootViewController = navigationController
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
