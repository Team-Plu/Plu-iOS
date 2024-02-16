//
//  MyAnswerNavigation.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/24.
//

import Foundation

protocol MyAnswerNavigation: AnyObject {
    func pop()
    func completeButtonTapped(answer: String)
}
