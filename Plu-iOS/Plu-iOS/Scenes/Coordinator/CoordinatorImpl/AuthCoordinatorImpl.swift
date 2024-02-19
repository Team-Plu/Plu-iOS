//
//  AuthCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit


final class AuthCoordinatorImpl: AuthCoordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showLoginViewController() {
        let manager = LoginManagerImpl()
        let loginViewModelImpl = LoginViewModelImpl(manager: manager)
        loginViewModelImpl.delegate = self
        let loginViewController = LoginViewController(viewModel: loginViewModelImpl)
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func showTabbarController() {
        let tabbarCoordinator = TabBarCoordinatorImpl(navigationController: self.navigationController)
        tabbarCoordinator.showTabbarController()
    }
    
    func showOnboardingController() {
        let manger = NicknameManagerStub()
        let viewModel = OnboardingViewModelImpl(manager: manger)
        viewModel.delegate = self
        let onboardingViewController = OnboardingViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(onboardingViewController, animated: true)
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AuthCoordinatorImpl: LoginNavigation {
    func loginButtonTapped(type: LoginState) {
        switch type {
        case .loginSuccess:
            self.showOnboardingController()
        case .userNotFound:
            self.showOnboardingController()
        }

    }
}

extension AuthCoordinatorImpl: OnboardingNavigation {
    func backButtonTapped() {
        self.pop()
    }
    
    func signInButtonTapped() {
        self.showTabbarController()
    }
}
