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
        let keyboardWillShowSubject: PassthroughSubject<Void, Never>
        let keyboardWillHideSubject: PassthroughSubject<Void, Never>
    }
    
    struct MyAnswerOutput {
        let keyboardStatePublisher: AnyPublisher<Bool, Never>
    }
    
    func transform(input: MyAnswerInput) -> MyAnswerOutput {
        let keyboardWillShowSubject = input.keyboardWillShowSubject
            .map { true }
            .eraseToAnyPublisher()
        
        let keyboardWillHideSubject = input.keyboardWillHideSubject
            .map { false }
            .eraseToAnyPublisher()
        
        let mergePublisher = keyboardWillShowSubject.merge(with: keyboardWillHideSubject).eraseToAnyPublisher()
        
        return MyAnswerOutput(keyboardStatePublisher: mergePublisher)
    }
    
    
}
