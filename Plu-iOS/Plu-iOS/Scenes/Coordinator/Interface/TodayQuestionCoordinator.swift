//
//  TodayQuestionCoordinator.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import Foundation

protocol TodayQuestionCoordinator: Coordinator {
    func showTodayQuestionViewController()
    func showMyPageViewController()
    func showMyAnswerViewController()
    func showOtherAnswersViewController()
}

