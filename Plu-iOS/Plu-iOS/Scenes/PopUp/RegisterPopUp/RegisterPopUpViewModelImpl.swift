//
//  RegisterPopUpViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/15.
//

import Foundation
import Combine

protocol RegisterPopUpViewModel {
    func transform(input: RegisterPopUpInput) -> RegisterPopUpOutput
}

struct RegisterPopUpInput {
    let buttonSubject: PassthroughSubject<RegisterPopUpViewController.ButtonType, Never>
}

struct RegisterPopUpOutput {}

final class RegisterPopUpViewModelImpl: RegisterPopUpViewModel {
    
    let coordinator: PopUpCoordinator
    var cancelBag = Set<AnyCancellable>()
    
    init(coordinator: PopUpCoordinator) {
        self.coordinator = coordinator
    }

    func transform(input: RegisterPopUpInput) -> RegisterPopUpOutput {
        input.buttonSubject
            .sink { type in
                switch type {
                case .reCheck:
                    self.coordinator.dismiss()
                case .register:
                    self.coordinator.accept(type: .register)
                }
            }
            .store(in: &cancelBag)
        return RegisterPopUpOutput()
    }
}
