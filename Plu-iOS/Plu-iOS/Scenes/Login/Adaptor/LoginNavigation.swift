//
//  LoginNavigation.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/19/23.
//

import Foundation

@frozen
enum LoginType {
    case kakao
    case apple
    
    var object: SocialLogin {
        switch self {
        case .apple:
            return Apple()
        case .kakao:
            return Kakao()
        }
    }
    
    var rawValue: String {
        return "\(self)".uppercased()
    }
}


protocol LoginNavigation: AnyObject {
    func loginButtonTapped(type: LoginState)
}
