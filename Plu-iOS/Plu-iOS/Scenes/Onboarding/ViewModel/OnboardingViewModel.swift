//
//  OnboardingViewModel.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/10.
//

import Foundation
import Combine

struct OnboardingInput {
    let textFieldSubject: AnyPublisher<String, Never>
    let backButtonTapped: PassthroughSubject<Void, Never>
    let singInButtonTapped: PassthroughSubject<String, Never>
}

struct OnboardingOutput {
    let nickNameResultPublisher: AnyPublisher<NicknameState, Never>
    let signInStatePublisher: PassthroughSubject<LoadingState, Never>
}

protocol OnboardingViewModel: ViewModel where Input == OnboardingInput, Output == OnboardingOutput {
}

