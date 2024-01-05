//
//  AnswerDetailCoordinator.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import Foundation


protocol AnswerDetailCoordinator: Coordinator {
    func showAnswerDetailViewController(id: Int)
    func pop()
}


