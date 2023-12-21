//
//  LoginAdaptor.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/19/23.
//

import Foundation


final class LoginAdaptor: LoginNavigation {
    
    let coordinator: AuthCoordinator
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    func loginButtonTapped(type: LoginState) {
        switch type {
        case .loginSuccess:
            self.coordinator.showOnboardingController()
//            self.coordinator.showTabbarController()
        case .userNotFound:
            self.coordinator.showOnboardingController()
        }
    }    
}
