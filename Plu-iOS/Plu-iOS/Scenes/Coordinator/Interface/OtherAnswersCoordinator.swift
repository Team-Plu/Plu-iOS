//
//  OtherAnswersCoordinator.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import Foundation

protocol OtherAnswersCoordinator: Coordinator {
    func showOtherAnswersViewController()
    func showAnswerDetailViewController()
    func pop()
}
