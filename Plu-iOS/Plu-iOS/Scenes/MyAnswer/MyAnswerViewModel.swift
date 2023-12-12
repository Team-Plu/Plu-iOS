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
    }
    
    struct MyAnswerOutput {
        let keyboardStatePublisher: AnyPublisher<Bool, Never>
    }
    
    func transform(input: MyAnswerInput) -> MyAnswerOutput {
        let keyboardTypeSubject = input.keyboardStateSubject
            .map { type -> Bool in
                switch type {
                case .show:
                    return true
                case .hide:
                    return false
                }
            }
            .eraseToAnyPublisher()
        
        return MyAnswerOutput(keyboardStatePublisher: keyboardTypeSubject)
    }
    
    
}
