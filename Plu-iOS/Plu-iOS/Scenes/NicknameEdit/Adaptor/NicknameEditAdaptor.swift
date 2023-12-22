//
//  NicknameEditAdaptor.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/21.
//

import Foundation

final class NicknameEditAdaptor: NicknameEditNavigation {

    let coordinator: MyPageCoordinator
    
    init(coordinator: MyPageCoordinator) {
        self.coordinator = coordinator
    }
    
    func backButtonTapped() {
        self.coordinator.pop()
    }
    
    func nicknameChangeCompleteButtonTapped() {
        self.coordinator.pop()
    }
}
