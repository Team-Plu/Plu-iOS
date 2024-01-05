//
//  OnboardingInput.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/21.
//

import Foundation
import Combine

struct OnboardingInput {
    let textFieldSubject: AnyPublisher<String, Never>
    let backButtonTapped: PassthroughSubject<Void, Never>
    let singInButtonTapped: PassthroughSubject<String, Never>
}
