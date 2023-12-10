//
//  OnboardingViewModel.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/10.
//

import Foundation
import Combine

final class OnboardingViewModel {
    
    struct OnboardingInput {
        let textFieldSubject: CurrentValueSubject<String, Never>
    }
    
    struct OnboardingOutput {
        let clearButtonTypePublisher: AnyPublisher<PluTextField.ClearButtonType, Never>
    }
    
    func transform(input: OnboardingInput) -> OnboardingOutput {
        let clearButtonTypePublisher = input.textFieldSubject
            .map { input -> PluTextField.ClearButtonType in
                return input.isEmpty ? .hide : .show
            }
            .eraseToAnyPublisher()
        return OnboardingOutput(clearButtonTypePublisher: clearButtonTypePublisher)
    }
}
