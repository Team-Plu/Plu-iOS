//
//  MyAnswerViewModel.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/11.
//

import Foundation

import Combine

final class MyAnswerViewModel {
    
    private var cancelBag = Set<AnyCancellable>()
    
    struct MyAnswerInput {
        let keyboardStateSubject: PassthroughSubject<KeyboardType, Never>
        let textViewTextCountSubject: PassthroughSubject<String, Never>
    }
    
    struct MyAnswerOutput {
        let keyboardStatePublisher: AnyPublisher<Bool, Never>
        let textViewTextCountPublisher: AnyPublisher<Bool, Never>
    }
    
    func transform(input: MyAnswerInput) -> MyAnswerOutput {
        let keyboardTypeSubject = input.keyboardStateSubject
            .map { type -> Bool in
                self.checkKeyboardType(type: type)
            }
            .eraseToAnyPublisher()
        
        let textViewTextCountSubject = input.textViewTextCountSubject
            .map { text in
                self.checkTextViewTextCount(input: text)
            }
            .eraseToAnyPublisher()
        
        return MyAnswerOutput(keyboardStatePublisher: keyboardTypeSubject,
                              textViewTextCountPublisher: textViewTextCountSubject)
    }
    
}

extension MyAnswerViewModel {
    private func checkKeyboardType(type: KeyboardType) -> Bool {
        type == .show ? true : false
    }
    private func checkTextViewTextCount(input: String) -> Bool {
        input.count == 0 ? false : true
    }
}
