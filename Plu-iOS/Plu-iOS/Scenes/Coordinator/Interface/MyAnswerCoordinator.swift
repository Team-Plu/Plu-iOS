//
//  MyAnswerCoordinator.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import Foundation

protocol MyAnswerCoordinator: Coordinator {
    func showMyAnswerViewController()
    func presentRegisterPopUpViewController()
    func pop()
}
