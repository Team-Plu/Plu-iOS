//
//  NicknameEditViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/11.
//

import Foundation
import Combine

final class NicknameEditViewModelImpl: NicknameEditViewModel, NicknameCheck {
    var nickNameManager: NicknameManager
    var delegate: NicknameEditNavigation?
    
    var vaildNicknameSubject = textFieldVaildChecker()
    var cancelBag = Set<AnyCancellable>()
    
    init(nickNameManager: NicknameManager) {
        self.nickNameManager = nickNameManager
    }

    func transform(input: NicknameEditInput) -> NicknameEditOutput {
        let loadingViewSubject: AnyPublisher<LoadingState, Never> = input.naviagtionRightButtonTapped
            .requestAPI(failure: .error(message: "닉네임 수정 오류 발생")) { nickname in
                try await Task.sleep(nanoseconds: 1000000000)
                try await self.nickNameManager.changeNickName(newNickname: nickname)
                self.delegate?.nicknameChangeCompleteButtonTapped()
                return .end
            } errorHandler: { error in
                // 에러처리
            }
        
        input.naviagtionLeftButtonTapped
            .sink { [weak self] in
                self?.delegate?.backButtonTapped()
            }
            .store(in: &cancelBag)
        
        let nickNameResultPublisher = self.nicknamePublisher(from: input.textFieldSubject, to: self.vaildNicknameSubject, with: nickNameManager)
        
        return NicknameEditOutput(nickNameResultPublisher: nickNameResultPublisher, loadingViewSubject: loadingViewSubject)
    }
}
