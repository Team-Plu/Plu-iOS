//
//  MyAnswerViewModel.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/11.
//

import Foundation
import Combine

protocol MyAnswerViewModel: ViewModel where MyAnswerInput == Input, MyAnswerOutput == Output {}

struct MyAnswerInput {
    let keyboardStateSubject: PassthroughSubject<KeyboardType, Never>
    let textViewTextCountSubject: PassthroughSubject<String, Never>
    let completeButtonTapped: PassthroughSubject<String, Never>
    let backButtonTapped: PassthroughSubject<Void, Never>
}

struct MyAnswerOutput {
    let keyboardStatePublisher: AnyPublisher<Bool, Never>
    let textViewTextCountPublisher: AnyPublisher<Bool, Never>
}
