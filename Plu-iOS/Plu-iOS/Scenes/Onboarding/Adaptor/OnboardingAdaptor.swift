//
//  OnboardingAdaptor.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/19.
//

import Foundation

final class OnboardingAdaptor: OnboardingNavigation {
    
    let  coordinator: AuthCoordinator
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    func backButtonTapped() {
        self.coordinator.pop()
    }
    
    func signInButtonTapped() {
        self.coordinator.showTabbarController()
    }
    
}
