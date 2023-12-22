//
//  OnboardingOutput.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/21.
//

import Foundation
import Combine

struct OnboardingOutput {
    let nickNameResultPublisher: AnyPublisher<NicknameState, Never>
    let signInStatePublisher: AnyPublisher<LoadingState, Never>
}
