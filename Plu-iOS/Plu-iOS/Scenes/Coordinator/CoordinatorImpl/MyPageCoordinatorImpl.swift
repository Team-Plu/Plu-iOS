//
//  MyPageCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit

protocol MyPageDelegate: AnyObject {
    func alarmAcceptTapped()
}

final class MyPageCoordinatorImpl: MyPageCoordinator {
    
    weak var delegate: MyPageDelegate?
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showMyPageViewController() {
        let manager = MyPageManagerStub()
        let viewModel = MypageViewModelImpl(manager: manager)
        viewModel.delegate = self
        let mypageViewController = MyPageViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(mypageViewController, animated: true)
    }
    
    func presentAlarmPopUpViewController() {
        let viewModel = AlarmPopUpViewModelImpl()
        viewModel.delegate = self
        let alarmPopUp = AlarmPopUpViewController(viewModel: viewModel)
        self.navigationController?.present(alarmPopUp, animated: true)
    }
    
    func showProfileEditViewController() {
        let manager = NicknameManagerStub()
        let viewModel = NicknameEditViewModelImpl(nickNameManager: manager)
        viewModel.delegate = self
        let profileEditViewController = NicknameEditViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(profileEditViewController, animated: true)
    }
    
    func showResignViewController() {
        let manager = ResignManagerImpl()
        let viewModel = ResignViewModelImpl(manager: manager)
        viewModel.delegate = self
        let resignViewController = ResignViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(resignViewController, animated: true)
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MyPageCoordinatorImpl: ResignNavigation {
    func resignButtonTapped() {
        self.exitUserToSplash()
    }
    
}

extension MyPageCoordinatorImpl: AlaramNavigation {
    func alarmContinueButtonTapped() {
        self.navigationController?.dismiss(animated: true) {
            self.delegate?.alarmAcceptTapped()
        }
    }
    
    func alarmCancelButtonTapped() {
        self.navigationController?.dismiss(animated: true)
    }
    
    
}


extension MyPageCoordinatorImpl: MyPageNavigation {
    func navigation(from type: MypageNavigationType) {
        switch type {
        case .header:
            self.showProfileEditViewController()
        case .back:
            self.pop()
        case .resign:
            self.showResignViewController()
        case .logout:
            print("로그아웃이 눌림")
        case .alarm:
            self.presentAlarmPopUpViewController()
        case .faq:
            print("faq가 눌림")
        case .openSource:
            print("오픈소스가 눌림")
        case .privacy:
            print("개인정보가 눌림")
        }
    }
}

extension MyPageCoordinatorImpl: NicknameEditNavigation {
    func backButtonTapped() {
        self.pop()
    }
    
    func nicknameChangeCompleteButtonTapped() {
        self.pop()
    }
}
