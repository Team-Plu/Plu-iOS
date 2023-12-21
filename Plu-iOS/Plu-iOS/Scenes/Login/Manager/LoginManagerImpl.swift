//
//  LoginManagerImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/19/23.
//

import Foundation


final class LoginManagerImpl: LoginManager {
    func login(type: LoginType, token: String) async throws {
        print("\(type.rawValue): \(token)으로 로그인 시도")
        if type == .kakao {
            return
        } else {
            throw NetworkError.serverError
        }
    }
}
