//
//  NicknameEditViewModel.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/11.
//

import Foundation
import Combine

final class NicknameEditViewModel: NicknameCheck {
    var nickNameManager: NicknameManager
    
    var vaildNicknameSubject = textFieldVaildChecker()
    
    init(nickNameManager: NicknameManager) {
        self.nickNameManager = nickNameManager
    }
    
    struct NicknameEditInput {
        let textFieldSubject: PassthroughSubject<String, Never>
    }
    
    struct NicknameEditOutput {
        let nickNameResultPublisher: AnyPublisher<NicknameState, Never>
    }
    
    func transform(input: NicknameEditInput) -> NicknameEditOutput {
        let nicknameInput = input.textFieldSubject
        let checker = self.vaildNicknameSubject
        let nickNameResultPublisher = self.makeNicknameResultPublisher(from: nicknameInput, to: checker, with: nickNameManager)
        return NicknameEditOutput(nickNameResultPublisher: nickNameResultPublisher)
    }
}
