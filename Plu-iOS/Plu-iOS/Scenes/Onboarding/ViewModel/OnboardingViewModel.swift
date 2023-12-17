//
//  OnboardingViewModel.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/10.
//

import Foundation
import Combine

struct OnboardingInput {
    let textFieldSubject: PassthroughSubject<String, Never>
    let navigationSubject: PassthroughSubject<OnboardingNavigationType, Never>
}

struct OnboardingOutput {
    let nickNameResultPublisher: AnyPublisher<NicknameState, Never>
}

protocol OnboardingViewModel {
    func transform(input: OnboardingInput) -> OnboardingOutput
}

final class OnboardingViewModelImpl: OnboardingViewModel, NicknameCheck {

    var nickNameManager: NicknameManager
    var coordinator: AuthCoordinator
    var vaildNicknameSubject = textFieldVaildChecker()
    var navigationSubject = PassthroughSubject<OnboardingNavigationType, Never>()
    var cancelBag = Set<AnyCancellable>()
    
    init(manager: NicknameManager, coordinator: AuthCoordinator) {
        self.nickNameManager = manager
        self.coordinator = coordinator
    }
    
    func transform(input: OnboardingInput) -> OnboardingOutput {
        self.navigationSubject
            .receive(on: DispatchQueue.main)
            .sink { type in
                switch type {
                case .backButtonTapped:
                    self.coordinator.pop()
                case .signInButtonTapped:
                    self.coordinator.showTabbarController()
                }
            }
            .store(in: &cancelBag)
        
        input.navigationSubject
            .sink { [weak self] in self?.navigationSubject.send($0) }
            .store(in: &cancelBag)
        
        let nicknameInput = input.textFieldSubject
        let checker = self.vaildNicknameSubject
        let nickNameResultPublisher = self.makeNicknameResultPublisher(from: nicknameInput, to: checker, with: nickNameManager)
        return OnboardingOutput(nickNameResultPublisher: nickNameResultPublisher)
    }
}


