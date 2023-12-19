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
        let loginViewController = LoginViewController(coordinator: self)
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func showTabbarController() {
        let tabbarCoordinator = TabBarCoordinatorImpl(navigationController: self.navigationController)
        tabbarCoordinator.showTabbarController()
    }
    
    func showOnboardingController() {
        let adaptor = OnboardingAdaptor(coordinator: self)
        let manger = NicknameManagerStub()
        let viewModel = OnboardingViewModelImpl(manager: manger, adaptor: adaptor)
        let onboardingViewController = OnboardingViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(onboardingViewController, animated: true)
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
}
