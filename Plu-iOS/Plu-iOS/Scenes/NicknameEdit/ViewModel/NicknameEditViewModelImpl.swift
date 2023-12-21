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
    var adaptor: NicknameEditNavigation
    
    var vaildNicknameSubject = textFieldVaildChecker()
    var cancelBag = Set<AnyCancellable>()
    
    init(nickNameManager: NicknameManager, adaptor: NicknameEditNavigation) {
        self.nickNameManager = nickNameManager
        self.adaptor = adaptor
    }

    func transform(input: NicknameEditInput) -> NicknameEditOutput {
        
        let loadingViewSubject = input.naviagtionRightButtonTapped
            .flatMap { newNickname -> AnyPublisher<LoadingState, Never> in
                return Future<LoadingState, Error> { promise in
                    Task {
                        do {
                            try await Task.sleep(nanoseconds: 1000000000)
                            try await self.nickNameManager.changeNickName(newNickname: newNickname)
                            self.adaptor.nicknameChangeCompleteButtonTapped()
                            promise(.success(.end))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                .catch { error in
                    Just(.error(message: "닉네임 수정 오류 발생"))
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        
        input.naviagtionLeftButtonTapped
            .sink { [weak self] in
                self?.adaptor.backButtonTapped()
            }
            .store(in: &cancelBag)
        
        let nicknameInput = input.textFieldSubject
        let checker = self.vaildNicknameSubject
        let nickNameResultPublisher = self.makeNicknameResultPublisher(from: nicknameInput, to: checker, with: nickNameManager)
        return NicknameEditOutput(nickNameResultPublisher: nickNameResultPublisher, loadingViewSubject: loadingViewSubject)
    }
}
