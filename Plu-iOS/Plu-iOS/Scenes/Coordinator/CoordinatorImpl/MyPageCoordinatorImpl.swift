//
//  MyPageCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit

protocol MypageAlarmResultDelegate: AnyObject {
    func isAccept()
}

final class MyPageCoordinatorImpl: MyPageCoordinator {
    weak var delegate: MypageAlarmResultDelegate?
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showMyPageViewController() {
        let adaptor = MypageAdaptor(coorinator: self)
        let manager = MyPageManagerStub()
        let mypageViewController = MyPageViewController(viewModel: MypageViewModelImpl(adaptor: adaptor, manager: manager))
        self.navigationController?.pushViewController(mypageViewController, animated: true)
    }
    
    func presentAlarmPopUpViewController() {
        let popUpCoordinator = PopUpCoordinatorImpl(navigationController: self.navigationController)
        popUpCoordinator.alarmDelegate = self
        popUpCoordinator.show(type: .alarm(.mypage))
    }
    
    func showProfileEditViewController() {
        let adaptor = NicknameEditAdaptor(coordinator: self)
        let manager = NicknameManagerStub()
        let viewModel = NicknameEditViewModelImpl(nickNameManager: manager, adaptor: adaptor)
        let profileEditViewController = NicknameEditViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(profileEditViewController, animated: true)
    }
    
    func showResignViewController() {
        let resignViewController = ResignViewController(coordinator: self)
        self.navigationController?.pushViewController(resignViewController, animated: true)
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MyPageCoordinatorImpl: AlarmDelegate {
    func isAccept() {
        self.delegate?.isAccept()
    }
}
