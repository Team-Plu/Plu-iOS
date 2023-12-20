//
//  OnboardingViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/19.
//

import Foundation
import Combine

final class OnboardingViewModelImpl: OnboardingViewModel, NicknameCheck {
    
    enum OnboardingFlowType {
        case backButtonTapped, signInButtonTapped
    }

    var nickNameManager: NicknameManager
    var adaptor: OnboardingNavigation
    var vaildNicknameSubject = textFieldVaildChecker()
    var navigationSubject = PassthroughSubject<OnboardingFlowType, Never>()
    var cancelBag = Set<AnyCancellable>()
    
    init(manager: NicknameManager, adaptor: OnboardingNavigation) {
        self.nickNameManager = manager
        self.adaptor = adaptor
    }
    
    func transform(input: OnboardingInput) -> OnboardingOutput {
        
        let nicknameInput = input.textFieldSubject
        let checker = self.vaildNicknameSubject
        let nickNameResultPublisher = self.makeNicknameResultPublisher(from: nicknameInput, to: checker, with: nickNameManager)
        
        self.navigationSubject
            .receive(on: DispatchQueue.main)
            .sink { type in
                switch type {
                case .backButtonTapped:
                    self.adaptor.backButtonTapped()
                case .signInButtonTapped:
                    self.adaptor.signInButtonTapped()
                }
            }
            .store(in: &cancelBag)
        
        input.backButtonTapped
            .sink { _ in
                self.navigationSubject.send(.backButtonTapped)
            }
            .store(in: &cancelBag)
        

        let signInStatePublisher = input.singInButtonTapped
            .flatMap { nickname -> AnyPublisher<LoadingState, Never> in
                return Future<LoadingState, Error> { promise in
                    Task {
                        do {
                            try await Task.sleep(nanoseconds: 100_000_000_0)
                            try await self.nickNameManager.registerUser(nickName: nickname)
                            self.navigationSubject.send(.signInButtonTapped)
                            promise(.success(.end))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                .catch { _ in
                    Just(.error(message: "유저 등록 오류 발생"))
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    
        
        return OnboardingOutput(nickNameResultPublisher: nickNameResultPublisher, signInStatePublisher: signInStatePublisher)
    }
}

