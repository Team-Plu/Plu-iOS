//
//  LoginViewModelImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/19/23.
//

import Foundation
import Combine

enum LoginState {
    case end
    case error(message: String)
}

enum FlowType {
    case loginSuccess
    case userNotFound
}

final class LoginViewModelImpl: LoginViewModel {
    
    private let manager: LoginManager
    private let navigator: LoginNavigation
    
    private let navigationSubject = PassthroughSubject<FlowType, Never>()
    private var cancelBag = Set<AnyCancellable>()
    
    init(navigator: LoginNavigation, manager: LoginManager) {
        self.manager = manager
        self.navigator = navigator
        bind()
    }
    
    private func bind() {
        navigationSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] flow in
                self?.navigator.loginButtonTapped(type: flow)
            }
            .store(in: &cancelBag)
    }
    
    func transform(input: LoginViewModelInput) -> LoginViewModelOutput {
        let loginResult = input.loginButtonTapped
            .flatMap { loginType -> AnyPublisher<(type: LoginType, state: LoginState), Never> in
                return loginType == .kakao
                ? self.makeKakaoFuture()
                : self.makeAppleFuture()
            }
            .eraseToAnyPublisher()
        
        
        return LoginViewModelOutput(loginResult: loginResult)
    }
}

//MARK: - Network

extension LoginViewModelImpl {
    private func makeKakaoFuture() -> AnyPublisher<(type: LoginType, state: LoginState), Never> {
        return Future<(type: LoginType, state: LoginState), NetworkError> { promise in
            Task {
                do {
                    try await Task.sleep(nanoseconds: 100_000_000_0)
                    let kakaoToken = try await self.loginKakaoWithApp()
                    try await self.manager.login(type: .kakao, token: kakaoToken)
                    self.navigationSubject.send(.loginSuccess)
                    promise(.success((type: .kakao, state: .end)))
                } catch {
                    promise(.failure(error as! NetworkError))
                }
            }
        }.catch { error in
            return Just((type: .kakao, state: .error(message: "카카오 로그인 실패")))
        }
        .eraseToAnyPublisher()
    }
    
    private func makeAppleFuture() -> AnyPublisher<(type: LoginType, state: LoginState), Never> {
        return Future<(type: LoginType, state: LoginState), NetworkError> { promise in
            Task {
                do {
                    try await Task.sleep(nanoseconds: 100_000_000_0)
                    let appleToken = try await self.loginApple()
                    try await self.manager.login(type: .apple, token: appleToken)
                    self.navigationSubject.send(.loginSuccess)
                    promise(.success((type: .apple, state: .end)))
                } catch {
                    promise(.failure(error as! NetworkError))
                }
            }
        }.catch { error in
            return Just((type: .apple, state: .error(message: "애플 로그인 실패")))
        }
        .eraseToAnyPublisher()
    }
    
    private func loginKakaoWithApp() async throws -> String {
        return "kakao app token"
    }
    
    private func loginKakaoWithWeb() async throws -> String {
        return "kakao web token"
    }
    
    private func loginApple() async throws -> String {
        return "apple token"
    }
}
