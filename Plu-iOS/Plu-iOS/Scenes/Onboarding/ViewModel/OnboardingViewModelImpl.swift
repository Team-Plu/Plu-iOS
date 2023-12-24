//
//  OnboardingViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/19.
//

import Foundation
import Combine

// 모든 비동기 코드는 optional의 데이터와 state가 무조건 들어가잖아
// 얘를 프로토콜로 빼고

final class OnboardingViewModelImpl: OnboardingViewModel, NicknameCheck {

    var nickNameManager: NicknameManager
    var adaptor: OnboardingNavigation
    var vaildNicknameSubject = textFieldVaildChecker()
    var cancelBag = Set<AnyCancellable>()
    
    init(manager: NicknameManager, adaptor: OnboardingNavigation) {
        self.nickNameManager = manager
        self.adaptor = adaptor
    }
    
    func transform(input: OnboardingInput) -> OnboardingOutput {
        
        input.backButtonTapped
            .sink { [weak self] _ in self?.adaptor.backButtonTapped() }
            .store(in: &cancelBag)
        
        let nickNameResultPublisher = self.nicknamePublisher(from: input.textFieldSubject, to: self.vaildNicknameSubject, with: nickNameManager)
        

        let signInStatePublisher: AnyPublisher<LoadingState, Never> = input.singInButtonTapped
            .requestAPI(failure: .error(message: "오류가발생했습니다")) { nickname in
                try await Task.sleep(nanoseconds: 100_000_000_0)
                try await self.nickNameManager.registerUser(nickName: nickname)
                self.adaptor.signInButtonTapped()
                return .end
            } errorHandler: { error in
                // 에러처리하는 코드
            }
    
        
        return OnboardingOutput(nickNameResultPublisher: nickNameResultPublisher, signInStatePublisher: signInStatePublisher)
    }
}


