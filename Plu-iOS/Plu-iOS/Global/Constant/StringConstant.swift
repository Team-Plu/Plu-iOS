//
//  StringConstant.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//

import Foundation

enum StringConstant {
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
    
    enum Onboarding {
        case title, subTitle, placeHolder
        var title: String {
            switch self {
            case .title: return "닉네임을 입력해주세요"
            case .subTitle: return "닉네임을 입력하면 가입이 완료됩니다."
            case .placeHolder: return "닉네임"
            }
        }
    }
}
