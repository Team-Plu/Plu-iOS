//
//  OnboardingViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/19.
//

import Foundation
import Combine

enum OnboardingNavigationType {
    case backButtonTapped
    case signInButtonTapped
}

final class OnboardingViewModelImpl: OnboardingViewModel, NicknameCheck {

    var nickNameManager: NicknameManager
    var adaptor: any OnboardingNavigation
    var vaildNicknameSubject = textFieldVaildChecker()
    var cancelBag = Set<AnyCancellable>()
    
    init(manager: NicknameManager, adaptor: some OnboardingNavigation) {
        self.nickNameManager = manager
        self.adaptor = adaptor
    }
    
    func transform(input: OnboardingInput) -> OnboardingOutput {
        
        input.backButtonTapped
            .sink { [weak self] _ in self?.adaptor.navigation(from: .backButtonTapped) }
            .store(in: &cancelBag)
        
        let nickNameResultPublisher = self.nicknamePublisher(from: input.textFieldSubject, to: self.vaildNicknameSubject, with: nickNameManager)
        

        let signInStatePublisher: AnyPublisher<LoadingState, Never> = input.singInButtonTapped
            .requestAPI(failure: .error(message: "오류가발생했습니다")) { nickname in
                try await Task.sleep(nanoseconds: 100_000_000_0)
                try await self.nickNameManager.registerUser(nickName: nickname)
                self.adaptor.navigation(from: .signInButtonTapped)
                return .end
            } errorHandler: { error in
                // 에러처리하는 코드
            }
    
        
        return OnboardingOutput(nickNameResultPublisher: nickNameResultPublisher, signInStatePublisher: signInStatePublisher)
    }
}


