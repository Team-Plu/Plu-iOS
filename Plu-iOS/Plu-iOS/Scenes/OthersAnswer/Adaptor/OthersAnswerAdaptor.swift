//
//  OthersAnswerAdaptor.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/22/23.
//

import Foundation


final class OthersAnswerAdaptor: OthersAnswerNavigation {
    
    private let coordinator: OtherAnswersCoordinator
    
    init(coordinator: OtherAnswersCoordinator) {
        self.coordinator = coordinator
    }
    
    func tableViewCellTapped(id: Int) {
        self.coordinator.showAnswerDetailViewController(id: id)
    }
    
    func navigationBackButtonTapped() {
        self.coordinator.pop()
    }
}
