//
//  AppleLoginService.swift
//  Plu-iOS
//
//  Created by 김민재 on 2/16/24.
//

import Foundation
import AuthenticationServices


final class AppleLoginService: NSObject {
    
    private var activeContinuation: CheckedContinuation<String, Error>?
    
    func login() async throws -> String {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
        
        return try await withCheckedThrowingContinuation { continuation in
            self.activeContinuation = continuation
        }
    }
    
}

extension AppleLoginService: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let identityToken = credential.identityToken
        else { return }
        
        
        self.activeContinuation?.resume(
            returning: String(data: identityToken , encoding: .utf8) ?? ""
        )
        self.activeContinuation = nil
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.activeContinuation?.resume(throwing: error)
        self.activeContinuation = nil
    }
    
    
}
