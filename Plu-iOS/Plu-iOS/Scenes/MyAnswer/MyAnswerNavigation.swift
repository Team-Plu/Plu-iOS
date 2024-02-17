//
//  MyAnswerNavigation.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/24.
//

import Foundation
import Combine

protocol MyAnswerNavigation: AnyObject {
    var myAnswerSubject: PassthroughSubject<Void, Never> { get set }
    func pop()
    func completeButtonTapped(answer: String)
}
