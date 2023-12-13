//
//  LoginCoordinator.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import Foundation


protocol AuthCoordinator: Coordinator {
    func showLoginViewController()
    func showTabbarController()
    func showOnboardingController()
    func pop()
}
