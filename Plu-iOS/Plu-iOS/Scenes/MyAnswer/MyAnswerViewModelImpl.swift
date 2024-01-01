//
//  MyAnswerViewModelImpl.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/24.
//

import Foundation
import Combine

final class MyAnswerViewModelImpl: MyAnswerViewModel {
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let adaptor: MyAnswerNavigation
    
    init(adaptor: MyAnswerNavigation) {
        self.adaptor = adaptor
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
        
        input.backButtonTapped
            .sink { [weak self] _ in
                self?.adaptor.pop()
            }
            .store(in: &cancelBag)
        
        input.completeButtonTapped
            .sink { [weak self] answer in
                self?.adaptor.completeButtonTapped(answer: answer)
            }
            .store(in: &cancelBag)
        
        return MyAnswerOutput(keyboardStatePublisher: keyboardTypeSubject,
                              textViewTextCountPublisher: textViewTextCountSubject)
    }
    
}

extension MyAnswerViewModelImpl {
    private func checkKeyboardType(type: KeyboardType) -> Bool {
        type == .show ? true : false
    }
    private func checkTextViewTextCount(input: String) -> Bool {
        input.count == 0 ? false : true
    }
}
