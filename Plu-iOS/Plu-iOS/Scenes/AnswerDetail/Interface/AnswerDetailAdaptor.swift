//
//  AnswerDetailAdaptor.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/21.
//

import Foundation

final class AnswerDetailAdaptor: AnswerDetailNavigation {

    private let coordinator: AnswerDetailCoordinator
    
    init(coordinator: AnswerDetailCoordinator) {
        self.coordinator = coordinator
    }
    
    func pop() {
        coordinator.pop()
    }
}
