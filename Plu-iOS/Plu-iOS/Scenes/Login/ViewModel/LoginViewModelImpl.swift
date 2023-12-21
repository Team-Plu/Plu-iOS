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
    var adaptor: LoginNavigation
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(adaptor: LoginNavigation, manager: LoginManager) {
        self.manager = manager
        self.adaptor = adaptor
    }
    
    func transform(input: LoginViewModelInput) -> LoginViewModelOutput {
        let loginResult = input.loginButtonTapped
            .flatMap { loginType -> AnyPublisher<(type: LoginType, state: LoadingState), Never> in
                self.makeSocialLoginFuture(socialLogin: loginType.object,
                                           manager: self.manager,
                                           navigator: self.adaptor)
            }
            .eraseToAnyPublisher()
        
        return LoginViewModelOutput(loginResult: loginResult)
    }
}
