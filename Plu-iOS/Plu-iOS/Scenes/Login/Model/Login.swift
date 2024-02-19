//
//  Login.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/20/23.
//

import Foundation
import Combine

protocol Login: AnyObject {
    var manager: LoginManager { get set }
    var delegate: LoginNavigation? { get set }
    func makeSocialLoginFuture(socialLogin: SocialLogin,
                               manager: LoginManager
    ) -> AnyPublisher<(type: LoginType, state: LoadingState), Never>
}

extension Login {
    @MainActor
    func makeSocialLoginFuture(socialLogin: SocialLogin,
                               manager: LoginManager
    ) -> AnyPublisher<(type: LoginType, state: LoadingState), Never> {
        return Future<(type: LoginType, state: LoadingState), NetworkError> { promise in
            Task {
                do {
                    let token = try await socialLogin.getToken()
                    try await manager.login(type: socialLogin.type, token: token)
                    self.delegate?.loginButtonTapped(type: .loginSuccess)
                    promise(.success((type: socialLogin.type, state: .end)))
                } catch {
                    promise(.failure(error as! NetworkError))
                }
            }
        }.catch { error in
            return Just((type: socialLogin.type, state: .error(message: socialLogin.errorMessage)))
        }
        .eraseToAnyPublisher()
    }
}
