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
    
    enum Resign {
        static let resignDescriptionText = "회원 탈퇴 시 기존에 등록한 게시글, 공감 등\n모든 활동 정보가 삭제되며 복구가 불가능합니다.\n정말 탈퇴하실 건가요?"
        static let resignTitleText = "Plu님과 이별인가요?\n너무 아쉬워요."
        static let reuseText = "다시 사용하기"
        static let resignText = "탈퇴하기"
    }
}
