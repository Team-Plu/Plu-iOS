//
//  LoginViewModelImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/19/23.
//

import Foundation
import Combine


final class LoginViewModelImpl: LoginViewModel, Login {
    
    var manager: LoginManager
    var navigator: LoginNavigation
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(navigator: LoginNavigation, manager: LoginManager) {
        self.manager = manager
        self.navigator = navigator
    }
    
    func transform(input: LoginViewModelInput) -> LoginViewModelOutput {
        let loginResult = input.loginButtonTapped
            .flatMap { loginType -> AnyPublisher<(type: LoginType, state: LoadingState), Never> in
                self.makeSocialLoginFuture(socialLogin: loginType.object)
            }
            .eraseToAnyPublisher()
        
        return LoginViewModelOutput(loginResult: loginResult)
    }
}

//@MainActor
//private extension LoginViewModelImpl {
    // 😋
//@MainActor
//func makeSocialLoginFuture(socialLogin: SocialLogin) -> AnyPublisher<(type: LoginType, state: LoadingState), Never> {
//    return Future<(type: LoginType, state: LoadingState), NetworkError> { promise in
//        Task {
//            do {
//                try await Task.sleep(nanoseconds: 100_000_000_0)
//                let token = try await socialLogin.getToken()
//                try await self.manager.login(type: socialLogin.type, token: token)
//                self.navigator.loginButtonTapped(type: .loginSuccess)
//                promise(.success((type: socialLogin.type, state: .end)))
//            } catch {
//                promise(.failure(error as! NetworkError))
//            }
//        }
//    }.catch { error in
//        return Just((type: socialLogin.type, state: .error(message: socialLogin.errorMessage)))
//    }
//    .eraseToAnyPublisher()
//}
    

//    func makeKakaoFuture() -> AnyPublisher<(type: LoginType, state: LoadingState), Never> {
//        return Future<(type: LoginType, state: LoadingState), NetworkError> { promise in
//            Task {
//                do {
////                    try await Task.sleep(nanoseconds: 100_000_000_0)
//                    //
//                    let kakaoToken = try await self.loginKakaoWithApp()
//                    try await self.manager.login(type: .kakao, token: kakaoToken)
//                    self.navigator.loginButtonTapped(type: .loginSuccess)
//                    // 변경
//                    promise(.success((type: .kakao, state: .end)))
//                } catch {
//                    promise(.failure(error as! NetworkError))
//                }
//            }
//        }.catch { error in
//            return Just((type: .kakao, state: .error(message: "카카오 로그인 실패")))
//        }
//        .eraseToAnyPublisher()
//    }
//    
//    func makeAppleFuture() -> AnyPublisher<(type: LoginType, state: LoadingState), Never> {
//        return Future<(type: LoginType, state: LoadingState), NetworkError> { promise in
//            Task {
//                do {
////                    try await Task.sleep(nanoseconds: 100_000_000_0)
//                    let appleToken = try await self.loginApple()
//                    try await self.manager.login(type: .apple, token: appleToken)
//                    self.navigator.loginButtonTapped(type: .loginSuccess)
//                    promise(.success((type: .apple, state: .end)))
//                } catch {
//                    promise(.failure(error as! NetworkError))
//                }
//            }
//        }.catch { error in
//            return Just((type: .apple, state: .error(message: "애플 로그인 실패")))
//        }
//        .eraseToAnyPublisher()
//    }
//}
