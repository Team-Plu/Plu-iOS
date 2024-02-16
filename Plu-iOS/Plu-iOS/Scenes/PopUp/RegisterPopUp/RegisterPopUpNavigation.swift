//
//  RegisterPopUpNavigation.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/26.
//

import Foundation

protocol RegisterPopUpNavigation: AnyObject {
    func dismiss()
    func completeButtonTapped()
}

//final class RegisterPopUpAdaptor: RegisterPopUpNavigation {
//
//    private let coordinator: PopUpCoordinator
//    
//    init(coordinator: PopUpCoordinator) {
//        self.coordinator = coordinator
//    }
//    
//    func dismiss() {
//        self.coordinator.dismiss()
//    }
//    
//    func completeButtonTapped(answer: String) {
//        self.coordinator.accept(type: .register(answer: answer))
//    }
//}
