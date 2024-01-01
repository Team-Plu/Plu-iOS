//
//  RegisterPopUpAdaptor.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/26.
//

import Foundation

protocol RegisterPopUpNavigation {
    func dismiss()
    func completeButtonTapped()
}

final class RegisterPopUpAdaptor: RegisterPopUpNavigation {

    private let coordinator: PopUpCoordinator
    
    init(coordinator: PopUpCoordinator) {
        self.coordinator = coordinator
    }
    
    func dismiss() {
        self.coordinator.dismiss()
    }
    
    func completeButtonTapped() {
        self.coordinator.accept(type: .register)
    }
}
