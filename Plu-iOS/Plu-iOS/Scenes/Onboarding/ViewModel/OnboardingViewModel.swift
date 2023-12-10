//
//  OnboardingViewModel.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/10.
//

import Foundation
import Combine

struct NicknameState {
    let errorDescription: String?
    let nextProcessButtonIsActive: Bool
}

extension NicknameState {
    init(_ type: StringConstant.Onboarding) {
        self.init(errorDescription: type.description, nextProcessButtonIsActive: type == .nickNameValid ? true : false)
    }
}

typealias textFieldInput = PassthroughSubject<String, Never>
typealias textFieldOutput = AnyPublisher<NicknameState, Never>
typealias textFieldVaildChecker = PassthroughSubject<String?, Never>

protocol NickNameCheck {
    var manager: NicknameManager { get set }
    var vaildNicknameSubject: textFieldVaildChecker { get }
    func makeNicknameResultPublisher(input: textFieldInput, checker: textFieldVaildChecker, manager: NicknameManager) -> textFieldOutput
    func getNicknameState(from input: String, to subject: textFieldVaildChecker) -> NicknameState
    func checkNicknamgLength(from input: String, _ length: Int) -> Bool
    func getNicknameStatePublisher(from input: textFieldInput, to checker: textFieldVaildChecker) -> textFieldOutput
    func getNicknameVaildPublisher(from checker: textFieldVaildChecker, with manager: NicknameManager) -> textFieldOutput
}

extension NickNameCheck where Self: AnyObject {
    func makeNicknameResultPublisher(input: textFieldInput, checker: textFieldVaildChecker, manager: NicknameManager) -> textFieldOutput {
        let stateFromNicknamePublisher = self.getNicknameStatePublisher(from: input, to: checker)
        let nickNameValidPublisher = self.getNicknameVaildPublisher(from: checker, with: manager)
        return stateFromNicknamePublisher.merge(with: nickNameValidPublisher).eraseToAnyPublisher()
    }
    
    
    func getNicknameState(from input: String, to subject: textFieldVaildChecker) -> NicknameState {
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
    
    func getNicknameVaildPublisher(from checker: textFieldVaildChecker, with manager: NicknameManager) -> textFieldOutput {
        return checker
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .compactMap { $0 }
            .flatMap { input -> AnyPublisher<NicknameState, Never> in
                return Future<NicknameState, Error> { promoise in
                    Task {
                        do {
                            let isValid = try await manager.judgeInputNicknameVaild(input: input)
                            promoise(.success(.init(isValid ? .nickNameValid : .nickNameNonValid)))
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
    }
    
    func getNicknameStatePublisher(from input: textFieldInput, to checker: textFieldVaildChecker) -> textFieldOutput {
        return input
            .map { input -> NicknameState in
                self.getNicknameState(from: input, to: checker)
            }
            .eraseToAnyPublisher()
    }
    
}

final class OnboardingViewModel: NickNameCheck {

    var manager: NicknameManager
    var vaildNicknameSubject = textFieldVaildChecker()
    
    init(manager: NicknameManager) {
        self.manager = manager
    }
    
    struct OnboardingInput {
        let textFieldSubject: PassthroughSubject<String, Never>
    }
    
    struct OnboardingOutput {
        let nickNameResultPublisher: AnyPublisher<NicknameState, Never>
    }
    
    func transform(input: OnboardingInput) -> OnboardingOutput {
        let nicknameInput = input.textFieldSubject
        let checker = self.vaildNicknameSubject
        let nickNameResultPublisher = self.makeNicknameResultPublisher(input: nicknameInput, checker: checker, manager: manager)
        return OnboardingOutput(nickNameResultPublisher: nickNameResultPublisher)
    }
}


