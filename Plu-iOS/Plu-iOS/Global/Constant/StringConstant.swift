//
//  StringConstant.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//

import Foundation

enum StringConstant {
    enum Onboarding {}
    enum Login {}
    enum MyPage {
        case alarm, faq, openSource, privacy, appVersion, logOut, resign
        
        var title: String {
            switch self {
            case .alarm: return "알림 설정"
            case .appVersion: return "앱버전"
            case .faq: return "FAQ"
            case .logOut: return "로그아웃"
            case .resign: return "탈퇴하기"
            case .openSource: return "오픈소스 라이브러리"
            case .privacy: return "개인정보 보호 및 약관"
            }
        }
    }
}
