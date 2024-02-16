//
//  KakaoLoginService.swift
//  Plu-iOS
//
//  Created by 김민재 on 2/16/24.
//

import Foundation

import KakaoSDKAuth
import KakaoSDKUser


final class KakaoLoginService {
    
    func login() async throws -> String {
        if UserApi.isKakaoTalkLoginAvailable() {
            return try await loginKakaoWithApp()
        }
        return try await loginKakaoWithWeb()
        
    }
    
    @MainActor
    private func loginKakaoWithApp() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk { oAuthToken, error in
                guard error == nil else {
                    continuation.resume(throwing: NetworkError.serverError)
                    return
                }
                guard let oAuthToken = oAuthToken else {
                    continuation.resume(throwing: NetworkError.serverError)
                    return
                }
                continuation.resume(returning: oAuthToken.accessToken)
            }
        }
    }
    
    @MainActor
    private func loginKakaoWithWeb() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount { oAuthToken, error in
                guard error == nil else {
                    continuation.resume(throwing: NetworkError.serverError)
                    return
                }
                guard let oAuthToken = oAuthToken else {
                    continuation.resume(throwing: NetworkError.serverError)
                    return
                }
                continuation.resume(returning: oAuthToken.accessToken)
            }
        }
    }
}
