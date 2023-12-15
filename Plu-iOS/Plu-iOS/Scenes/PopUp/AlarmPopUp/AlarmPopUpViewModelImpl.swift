//
//  AlarmPopUpViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/15.
//

import Foundation
import Combine

protocol AlarmPopUpViewModel {
    func transform(input: AlarmPopUpInput) -> AlarmPopUpOutput
}

struct AlarmPopUpInput {
    let buttonSubject: PassthroughSubject<AlarmPopUpViewController.ButtonType, Never>
}

struct AlarmPopUpOutput {}

final class AlarmPopUpViewModelImpl: AlarmPopUpViewModel {
    
    let coordinator: PopUpCoordinator
    var cancelBag = Set<AnyCancellable>()
    
    init(coordinator: PopUpCoordinator) {
        self.coordinator = coordinator
    }

    func transform(input: AlarmPopUpInput) -> AlarmPopUpOutput {
        input.buttonSubject
            .sink { type in
                switch type {
                case .reject:
                    self.coordinator.dismiss()
                case .accept:
                    self.coordinator.accept(type: .alarm)
                }
            }
            .store(in: &cancelBag)
        return AlarmPopUpOutput()
    }
}
