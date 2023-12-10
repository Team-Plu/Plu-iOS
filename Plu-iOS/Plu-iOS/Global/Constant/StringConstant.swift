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
        
        var description: String {
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
        case title, subTitle, placeHolder, textFieldEmpty, textFieldOver, textFieldError, nickNameNonValid, nickNameValid, none
        var description: String? {
            switch self {
            case .title: return "닉네임을 입력해주세요"
            case .subTitle: return "닉네임을 입력하면 가입이 완료됩니다."
            case .placeHolder: return "닉네임"
            case .textFieldEmpty: return "입력된 내용이 없습니다."
            case .textFieldOver: return "8자 이내로 입력해주세요."
            case .textFieldError: return "다시 시도해주세요."
            case .nickNameNonValid: return "이미 사용 중인 닉네임입니다."
            case .nickNameValid, .none: return nil
            }
        }
    }
    
    enum TodayQuestion {
        case myAnswer, everyAnswer, explanation
        
        var text: String {
            switch self {
            case .myAnswer: return "나의 답변 작성하기"
            case .everyAnswer: return "모두의 답변 보러 가기"
            case .explanation: return "모두의 답변은 나의 답변을 작성한 후에 확인할 수 있어요"
            }
        }
    }
}
