//
//  LoginViewModel.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/19/23.
//

import Foundation
import Combine

protocol LoginViewModel: ViewModel where Input == LoginViewModelInput, Output == LoginViewModelOutput {}

struct LoginViewModelInput {
    let loginButtonTapped: PassthroughSubject<LoginType, Never>
}

struct LoginViewModelOutput {
    let loginResult: AnyPublisher<(type: LoginType, state: LoadingState), Never>
}
