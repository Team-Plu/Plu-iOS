//
//  StringConstant.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//

import Foundation

enum StringConstant {
    enum Login {
        static let page1Title = "매일 오후 10시 전달되는\n오늘의 질문을 확인해 보세요"
        static let page2Title = "나의 답변을 작성하면\n모두의 답변을 볼 수 있어요"
        static let page3Title = "꾸준히 작성한 일기는\n기록 탭에서 모아볼 수 있어요"
    }
    
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
    
    enum Resign {
        static let resignDescriptionText = "회원 탈퇴 시 기존에 등록한 게시글, 공감 등\n모든 활동 정보가 삭제되며 복구가 불가능합니다.\n정말 탈퇴하실 건가요?"
        static let resignTitleText = "Plu님과 이별인가요?\n너무 아쉬워요."
        static let reuseText = "다시 사용하기"
        static let resignText = "탈퇴하기"
    }
  
    enum Onboarding {
        case title, subTitle
        var description: String? {
            switch self {
            case .title: return "닉네임을 입력해주세요"
            case .subTitle: return "닉네임을 입력하면 가입이 완료됩니다."
            }
        }
    }
    
    enum Nickname {
        case placeHolder, textFieldEmpty, textFieldOver, textFieldError, nickNameNonValid, nickNameValid, none
        var description: String? {
            switch self {
            case .placeHolder: return "닉네임"
            case .textFieldEmpty: return "입력된 내용이 없습니다."
            case .textFieldOver: return "8자 이내로 입력해주세요."
            case .textFieldError: return "다시 시도해주세요."
            case .nickNameNonValid: return "이미 사용 중인 닉네임입니다."
            /// 추후 삭제될 description입니다
            case .nickNameValid: return "사용 가능한 닉네임입니다."
            case .none: return nil
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
