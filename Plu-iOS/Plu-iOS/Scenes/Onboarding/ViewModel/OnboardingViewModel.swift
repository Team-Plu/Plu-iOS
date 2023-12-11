//
//  OnboardingViewModel.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/10.
//

import Foundation
import Combine

final class OnboardingViewModel: NicknameCheck {

    var nickNameManager: NicknameManager
    var vaildNicknameSubject = textFieldVaildChecker()
    
    init(manager: NicknameManager) {
        self.nickNameManager = manager
    }
    
    struct OnboardingInput {
        let textFieldSubject: PassthroughSubject<String, Never>
    }
    
    struct OnboardingOutput {
        let nickNameResultPublisher: AnyPublisher<NicknameState, Never>
    }
    
    func transform(input: OnboardingInput) -> OnboardingOutput {
        let nicknameInput = input.textFieldSubject
        let checker = self.vaildNicknameSubject
        let nickNameResultPublisher = self.makeNicknameResultPublisher(from: nicknameInput, to: checker, with: nickNameManager)
        return OnboardingOutput(nickNameResultPublisher: nickNameResultPublisher)
    }
}


