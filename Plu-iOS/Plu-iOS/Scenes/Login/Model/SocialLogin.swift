//
//  SocialLogin.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/20/23.
//

import Foundation


protocol SocialLogin {
    var type: LoginType { get set }
    var errorMessage: String { get set }

    func getToken() async throws -> String
}

final class Kakao: SocialLogin {
    var type: LoginType = .kakao
    
    private let kakaoService = KakaoLoginService()
    
    var errorMessage: String = "카카오 로그인 오류"
    
    func getToken() async throws -> String {
        return try await loginKakao()
    }
    
    private func loginKakao() async throws -> String {
        return try await kakaoService.login()
    }
    
}

final class Apple: SocialLogin {
    var type: LoginType = .apple
    
    private let appleService = AppleLoginService()
    
    var errorMessage: String = "애플 로그인 실패" 
    
    func getToken() async throws -> String {
        return try await loginApple()
    }
    
    private func loginApple() async throws -> String {
        // Apple 로직
        return try await appleService.login()
    }
}
