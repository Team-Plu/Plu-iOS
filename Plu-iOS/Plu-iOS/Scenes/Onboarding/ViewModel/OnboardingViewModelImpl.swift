//
//  OnboardingViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/19.
//

import Foundation
import Combine

struct AppData {
    let state: LoadingState
    let data: String?
}

extension AppData {
    static var testErrorCase: Self {
        return .init(state: .error(message: "에러발생"), data: nil)
    }
}

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
        
        let nicknameInput = input.textFieldSubject
        let checker = self.vaildNicknameSubject
        let nickNameResultPublisher = self.makeNicknameResultPublisher(from: nicknameInput, to: checker, with: nickNameManager)
        

        // 문제 1 타입추론이 안되서 타입 명시를 해줘야한다
        let signInStatePublisher: AnyPublisher<AppData, Never> = input.singInButtonTapped
            .makeFuture(failure: .testErrorCase) { nickname in
                try await Task.sleep(nanoseconds: 100_000_000_0)
                try await self.nickNameManager.registerUser(nickName: nickname)
                self.adaptor.signInButtonTapped()
                return .init(state: .end, data: nil)
            } errorHandler: { error in
                // 에러처리하는 코드
            }

        

    
        
        return OnboardingOutput(nickNameResultPublisher: nickNameResultPublisher, signInStatePublisher: signInStatePublisher)
    }
}

extension Publisher {
    func makeFuture<Output>(failure: Output, handler: @escaping (Self.Output) async throws -> (Output), errorHandler: @escaping ((NetworkError) -> ())) -> AnyPublisher<Output, Never> where Self.Failure == Never {
        return self
            .flatMap { input -> AnyPublisher<Output, Never> in
                return Future<Output, NetworkError> { promise in
                    Task {
                        do {
                            promise(.success(try await handler(input)))
                        } catch {
                            let networkError = error as! NetworkError
                            errorHandler(networkError)
                            promise(.failure(networkError))
                        }
                    }
                }
                .catch { _ in
                    Just(failure)
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

