//
//  OnboardingViewModel.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/10.
//

import Foundation
import Combine

final class OnboardingViewModel {
    
    struct OnboardingState {
        let errorDescription: String?
        let nextButtonActive: Bool
    }
    
    let vaildNicknameSubject = PassthroughSubject<String?, Never>()
    let manager: OnboardingManager
    
    init(manager: OnboardingManager) {
        self.manager = manager
    }
    
    struct OnboardingInput {
        let textFieldSubject: PassthroughSubject<String, Never>
    }
    
    struct OnboardingOutput {
        let nickNameResultPublisher: AnyPublisher<OnboardingState, Never>
    }
    
    func transform(input: OnboardingInput) -> OnboardingOutput {
        let nickNameRangeVaildPublisher = input.textFieldSubject
            .map { input -> OnboardingState in
                self.processNickname(from: input, to: self.vaildNicknameSubject)
            }
            .eraseToAnyPublisher()
        
        let nickNameValidPublisher = self.vaildNicknameSubject
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .compactMap { $0 }
            .flatMap { input -> AnyPublisher<OnboardingState, Never> in
                return Future<OnboardingState, Error> { promoise in
                    Task {
                        do {
                            
                            /// 추후에 삭제할 출력문 및 sleep
                            print("✨✨✨✨✨✨닉네임중복결과✨✨✨✨✨✨")
                            try await Task.sleep(nanoseconds: 100000000)
                            
                            
                            let isValid = try await self.manager.judgeInputNicknameVaild(input: input)
                            promoise(.success(.init(isValid ? .nickNameValid : .nickNameNonValid)))
                            
                            /// 추후에 삭제할 출력문
                            if isValid {
                                print("입력하신 닉네임 \(input)은(는) 사용할수있는 닉네임입니다")
                            } else  {
                                print("입력하신 닉네임 \(input)은(는) 사용할수없는 닉네임입니다")
                            }
                            print("임시로 넣어 놓은 닉네임 목록 : 의성, 민재, 찬미")
                    
                            
                        } catch {
                            promoise(.failure(error))
                        }
                    }
                }
                .catch { error in
                    Just(.init(.textFieldError))
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()

        let nickNameResultPublisher = nickNameRangeVaildPublisher.merge(with: nickNameValidPublisher)
            .eraseToAnyPublisher()
        
        return OnboardingOutput(nickNameResultPublisher: nickNameResultPublisher)
    }
}

private extension OnboardingViewModel {
    func processNickname(from input: String, to subject: PassthroughSubject<String?, Never>) -> OnboardingState {
        if input.isEmpty {
            subject.send(nil)
            return .init(.textFieldEmpty)
        } else if self.checkNicknamgLength(from: input, 8) {
            subject.send(nil)
            return .init(.textFieldOver)
        } else {
            subject.send(input)
            return .init(.none)
        }
    }
    
    func checkNicknamgLength(from input: String, _ length: Int) -> Bool {
        return input.count > length
    }
}

extension OnboardingViewModel.OnboardingState {
    init(_ type: StringConstant.Onboarding) {
        self.init(errorDescription: type.description, nextButtonActive: type == .nickNameValid ? true : false)
    }
}
