//
//  NicknameCheck.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/11.
//

import Foundation
import Combine

typealias textFieldInput = AnyPublisher<String, Never>
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
    func nicknamePublisher(from input: textFieldInput,
                                     to checker: textFieldVaildChecker,
                                     with manager: NicknameManager) -> textFieldOutput
}

extension NicknameCheck where Self: ViewModel {
    func nicknamePublisher(from input: textFieldInput, to checker: textFieldVaildChecker, with manager: NicknameManager) -> textFieldOutput {
        let stateFromNicknamePublisher = self.getNicknameStatePublisher(from: input, to: checker)
        let nickNameValidPublisher = self.getNicknameVaildPublisher(from: checker, with: manager)
        return stateFromNicknamePublisher.merge(with: nickNameValidPublisher).eraseToAnyPublisher()
    }
    
    func getNicknameState(from input: String, to subject: textFieldVaildChecker) -> NicknameState {
        if input.isEmpty {
            subject.send(nil)
            return .textFieldEmpty()
        } else if self.checkNicknamgLength(from: input, 8) {
            subject.send(nil)
            return .textFieldOver()
        } else {
            subject.send(input)
            return .none()
        }
    }
    
    func checkNicknamgLength(from input: String, _ length: Int) -> Bool {
        return input.count > length
    }
    
    func getNicknameVaildPublisher(from checker: textFieldVaildChecker, with manager: NicknameManager) -> textFieldOutput {
        return checker
            .debounce(for: 0.4, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .compactMap { $0 }
            .flatMap { input -> AnyPublisher<NicknameState, Never> in
                return Future<NicknameState, Error> { promoise in
                    Task {
                        do {
                            let isValid = try await manager.inputNicknameIsVaild(input: input)
                            print("✨✨✨닉네임중복처리 결과✨✨✨")
                            print("입력한 닉네임 : \(input)")
                            if isValid {
                                print("결과 : 사용가능")
                            } else {
                                print("결과 : 사용불가능")
                            }
                            promoise(.success(isValid ? .nickNameValid() : .nickNameNonValid()))
                        } catch {
                            promoise(.failure(error))
                        }
                    }
                }
                .catch { error in
                    Just(.textFieldError())
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
