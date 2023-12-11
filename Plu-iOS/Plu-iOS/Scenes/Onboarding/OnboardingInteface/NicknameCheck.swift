//
//  NicknameCheck.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/11.
//

import Foundation
import Combine

typealias textFieldInput = PassthroughSubject<String, Never>
typealias textFieldOutput = AnyPublisher<NicknameState, Never>
typealias textFieldVaildChecker = PassthroughSubject<String?, Never>

protocol NicknameCheck {
    var nickNameManager: NicknameManager { get set }
    var vaildNicknameSubject: textFieldVaildChecker { get }
    func getNicknameState(from input: String,
                          to subject: textFieldVaildChecker) -> NicknameState
    func checkNicknamgLength(from input: String, _ length: Int) -> Bool
    func getNicknameStatePublisher(from input: textFieldInput,
                                   to checker: textFieldVaildChecker) -> textFieldOutput
    func getNicknameVaildPublisher(from checker: textFieldVaildChecker,
                                   with manager: NicknameManager) -> textFieldOutput
    func makeNicknameResultPublisher(from input: textFieldInput,
                                     to checker: textFieldVaildChecker,
                                     with manager: NicknameManager) -> textFieldOutput
}

extension NicknameCheck where Self: AnyObject {
    func makeNicknameResultPublisher(from input: textFieldInput, to checker: textFieldVaildChecker, with manager: NicknameManager) -> textFieldOutput {
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
            .removeDuplicates()
            .compactMap { $0 }
            .flatMap { input -> AnyPublisher<NicknameState, Never> in
                return Future<NicknameState, Error> { promoise in
                    Task {
                        do {
                            let isValid = try await manager.inputNicknameIsVaild(input: input)
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
