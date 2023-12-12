//
//  MyPageCoordinator.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import Foundation


protocol MyPageCoordinator: Coordinator {
    func showMyPageViewController()
    func presentAlarmPopUpViewController()
    func showProfileEditViewController()
    func showResignViewController()
    func pop()
}
